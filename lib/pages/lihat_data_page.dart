import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serkom_kpu/model/pemilih_model.dart';
import 'package:serkom_kpu/pages/utils/app_colors.dart';
import 'package:serkom_kpu/services/db_pemilih.dart';

class LihatDataPage extends StatefulWidget {
  const LihatDataPage({super.key});

  @override
  State<LihatDataPage> createState() => _LihatDataPageState();
}

class _LihatDataPageState extends State<LihatDataPage> {
  List<PemilihModel>? listPemilih;

  Future<void> refreshData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Pemilih"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              DBPemilih.getAllPemilih().then((value) => log("$value"));
            },
            icon: const Icon(
              Icons.data_array,
              size: 25.0,
            ),
          ),
          IconButton(
            onPressed: () async {
              await showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Konfirmasi'),
                    content: const SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                              'Apakah anda yakin akan menghapus seluruh data pemilih?'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Tidak"),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColor.primaryColor,
                          side: const BorderSide(
                            color: AppColor.primaryColor,
                          ),
                        ),
                        onPressed: () {
                          DBPemilih.deletePemilih().then((value) =>
                              DBPemilih.getAllPemilih()
                                  .then((value) => log("$value")));
                          Navigator.pop(context);
                          refreshData();
                        },
                        child: const Text("Ya"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.delete_forever,
              size: 25.0,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: DBPemilih.getAllPemilih(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text("Error");
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text("No Data"));
          }
          final data = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final pemilih = data[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CardPemilih(
                  pemilih: pemilih,
                  index: index,
                  onDelete: refreshData,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CardPemilih extends StatelessWidget {
  final int index;
  final PemilihModel pemilih;
  final VoidCallback onDelete;

  const CardPemilih({
    super.key,
    required this.index,
    required this.pemilih,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  pemilih.namaLengkap!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    await DBPemilih.deleteData(id: pemilih.id!);
                    onDelete();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            AtributPemilih(namaAtribut: "NIK", value: pemilih.nik.toString()),
            AtributPemilih(
                namaAtribut: "No.HP", value: pemilih.nomorHandphone!),
            AtributPemilih(
                namaAtribut: "Jenis Kelamin", value: pemilih.jenisKelamin!),
            AtributPemilih(
              namaAtribut: "Tanggal",
              value: DateFormat("dd MMMM yyyy").format(
                DateTime.fromMillisecondsSinceEpoch(pemilih.tanggalPendataan!),
              ),
            ),
            AtributPemilih(namaAtribut: "Alamat", value: pemilih.alamatRumah!),
            const SizedBox(height: 16),
            if (pemilih.gambar != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  pemilih.gambar!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AtributPemilih extends StatelessWidget {
  final String namaAtribut;
  final String value;

  const AtributPemilih({
    super.key,
    required this.namaAtribut,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              namaAtribut,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
