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
          if (snapshot.data == null) return const CircularProgressIndicator();
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
                    user: listUsers,
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

class CardPemilih extends StatelessWidget {
  final Map user;

  const CardPemilih({
    Key? key,
    required this.user,
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
                  namaAtribut: "NIK", value: Text(user["nik"].toString())),
              const SizedBox(height: 3.0),
              AtributPemilih(
                  namaAtribut: "Nama", value: Text(user["namaLengkap"])),
              const SizedBox(height: 3.0),
              AtributPemilih(
                  namaAtribut: "No.HP", value: Text(user["nomorHandphone"])),
              const SizedBox(height: 3.0),
              AtributPemilih(
                  namaAtribut: "Jenis Kelamin",
                  value: Text(user["jenisKelamin"])),
              const SizedBox(height: 3.0),
              AtributPemilih(
                  namaAtribut: "Tanggal",
                  // value: Text(user["tanggalPendataan"].toString()),
                  value: Text(
                    DateFormat("dd MMMM yyyy").format(
                      DateTime.fromMillisecondsSinceEpoch(
                          user['tanggalPendataan']),
                    ),
                  )),
              const SizedBox(height: 3.0),
              AtributPemilih(
                namaAtribut: "Alamat",
                value: Text(
                  user["alamatRumah"],
                ),
              ),
              const SizedBox(height: 3.0),
              AtributPemilih(
                namaAtribut: "Gambar",
                value: Image.network(
                  "https://i.ibb.co/S32HNjD/no-image.jpg",
                  height: 170.0,
                  fit: BoxFit.fill,
                ),
              ),
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
