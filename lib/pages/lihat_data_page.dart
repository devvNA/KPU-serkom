import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serkom_kpu/model/pemilih_model.dart';
import 'package:serkom_kpu/services/db_pemilih.dart';

class LihatDataPage extends StatefulWidget {
  const LihatDataPage({super.key});

  @override
  State<LihatDataPage> createState() => _LihatDataPageState();
}

class _LihatDataPageState extends State<LihatDataPage> {
  List<PemilihModel>? listPemilih;

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
                              'Apakah anda yakin akan menghapus data pemilih?'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        onPressed: () {
                          DBPemilih.deletePemilih().then((value) =>
                              DBPemilih.getAllPemilih()
                                  .then((value) => log("$value")));
                          Navigator.pop(context);
                        },
                        child: const Text("Yes"),
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
          return ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 4.0,
              );
            },
            padding: const EdgeInsets.all(12.0),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final listUsers = data[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CardPemilih(
                    pemilih: listUsers,
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CardPemilih extends StatelessWidget {
  String gambar;
  final Map pemilih;

  CardPemilih({
    Key? key,
    this.gambar = "",
    required this.pemilih,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: Container(
          margin: const EdgeInsets.all(12),
          color: Colors.white,
          child: Column(
            children: [
              AtributPemilih(
                  namaAtribut: "NIK", value: Text(pemilih["nik"].toString())),
              const SizedBox(height: 3.0),
              AtributPemilih(
                  namaAtribut: "Nama", value: Text(pemilih["namaLengkap"])),
              const SizedBox(height: 3.0),
              AtributPemilih(
                  namaAtribut: "No.HP", value: Text(pemilih["nomorHandphone"])),
              const SizedBox(height: 3.0),
              AtributPemilih(
                  namaAtribut: "Jenis Kelamin",
                  value: Text(pemilih["jenisKelamin"])),
              const SizedBox(height: 3.0),
              AtributPemilih(
                  namaAtribut: "Tanggal",
                  value: Text(
                    DateFormat("dd MMMM yyyy").format(
                      DateTime.fromMillisecondsSinceEpoch(
                          pemilih['tanggalPendataan']),
                    ),
                  )),
              const SizedBox(height: 3.0),
              AtributPemilih(
                namaAtribut: "Alamat",
                value: Text(
                  pemilih["alamatRumah"],
                ),
              ),
              const SizedBox(height: 3.0),
              pemilih['gambar'] == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : AtributPemilih(
                      namaAtribut: "Gambar",
                      value: Image.network(
                        pemilih["gambar"],
                        filterQuality: FilterQuality.medium,
                        height: 200,
                        fit: BoxFit.cover,
                        alignment: Alignment.centerLeft,
                      ))
            ],
          ),
        ),
      ),
    );
  }
}

class AtributPemilih extends StatelessWidget {
  final String namaAtribut;
  final Widget value;

  const AtributPemilih({
    super.key,
    required this.namaAtribut,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            namaAtribut,
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
        const Expanded(
          flex: 0,
          child: Text(
            ":   ",
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: value,
        ),
      ],
    );
  }
}
