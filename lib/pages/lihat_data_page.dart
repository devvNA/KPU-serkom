import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LihatDataPage extends StatefulWidget {
  const LihatDataPage({super.key});

  @override
  State<LihatDataPage> createState() => _LihatDataPageState();
}

class _LihatDataPageState extends State<LihatDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Pemilih"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) {
            return const SizedBox(height: 5);
          },
          padding: const EdgeInsets.all(12.0),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final listUsers = users[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CardPemilih(
                  user: listUsers,
                )
              ],
            );
          },
        ),
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
                  namaAtribut: "NIK", value: Text(user["id"].toString())),
              AtributPemilih(namaAtribut: "Nama", value: Text(user["name"])),
              AtributPemilih(
                  namaAtribut: "No.HP", value: Text(user["no_handphone"])),
              AtributPemilih(
                namaAtribut: "Jenis Kelamin",
                value: Text(user["jenis_kelamin"]),
              ),
              AtributPemilih(
                namaAtribut: "Tanggal",
                value: Text(user["tanggal_pendataan"].toString()),
              ),
              const AtributPemilih(
                namaAtribut: "Alamat",
                value: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                ),
              ),
              AtributPemilih(
                namaAtribut: "Gambar",
                value: Image.network(
                  "https://images.unsplash.com/flagged/photo-1559502867-c406bd78ff24?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=685&q=80",
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

final tanggalPendataan = (DateFormat("dd/MM/yyyy").format(DateTime.now()));

List<Map<String, dynamic>> users = [
  {
    "id": 1,
    "email": "george.bluth@reqres.in",
    "name": "George Bluth",
    "avatar": "https://reqres.in/img/faces/1-image.jpg",
    "no_handphone": "082142185804",
    "jenis_kelamin": "Laki-laki",
    "tanggal_pendataan": tanggalPendataan
  },
  {
    "id": 2,
    "email": "janet.weaver@reqres.in",
    "name": "Janet Weaver",
    "photo": "https://reqres.in/img/faces/2-image.jpg",
    "no_handphone": "082142185804",
    "jenis_kelamin": "Laki-laki",
    "tanggal_pendataan": tanggalPendataan
  },
  {
    "id": 3,
    "email": "emma.wong@reqres.in",
    "name": "Emma Wong",
    "photo": "https://reqres.in/img/faces/3-image.jpg",
    "no_handphone": "082142185804",
    "jenis_kelamin": "Laki-laki",
    "tanggal_pendataan": tanggalPendataan
  },
  {
    "id": 4,
    "email": "eve.holt@reqres.in",
    "name": "Eve Holt",
    "photo": "https://reqres.in/img/faces/4-image.jpg",
    "no_handphone": "082142185804",
    "jenis_kelamin": "Perempuan",
    "tanggal_pendataan": tanggalPendataan
  },
  {
    "id": 5,
    "email": "charles.morris@reqres.in",
    "name": "Charles Morris",
    "photo": "https://reqres.in/img/faces/5-image.jpg",
    "no_handphone": "082142185804",
    "jenis_kelamin": "Perempuan",
    "tanggal_pendataan": tanggalPendataan
  },
  {
    "id": 6,
    "email": "tracey.ramos@reqres.in",
    "name": "Tracey Ramos",
    "photo": "https://reqres.in/img/faces/6-image.jpg",
    "no_handphone": "082142185804",
    "jenis_kelamin": "Laki-laki",
    "tanggal_pendataan": tanggalPendataan
  }
];
