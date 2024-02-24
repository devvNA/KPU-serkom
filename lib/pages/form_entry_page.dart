// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serkom_kpu/model/pemilih_model.dart';
import 'package:serkom_kpu/pages/utils/app_colors.dart';
import 'package:serkom_kpu/pages/widget/alert_banner.dart';
import '../services/db_pemilih.dart';
import 'widget/date_picker.dart';

class FormEntryPage extends StatefulWidget {
  const FormEntryPage({Key? key}) : super(key: key);

  @override
  State<FormEntryPage> createState() => _FormEntryPageState();
}

class _FormEntryPageState extends State<FormEntryPage> {
  int? nik;
  String? namaLengkap;
  String? nomorHandphone;
  String? jenisKelamin;
  int? tanggalPendataan;
  String? alamatRumah;
  String? gambar;
  File? _selectedImage;

  bool loading = false;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Entry"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // DBPemilih.deletePemilih();
              DBPemilih.getAllPemilih().then((value) => log(value.toString()));
            },
            icon: const Icon(
              Icons.delete_forever,
              size: 25.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "NIK",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 44.0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              6.0,
                            ),
                          ),
                        ),
                        child: Center(
                          child: TextField(
                            onChanged: (value) {
                              nik = int.parse(value);
                            },
                            style: const TextStyle(),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Nama",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 44.0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              6.0,
                            ),
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            namaLengkap = value;
                          },
                          style: const TextStyle(),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "No. HP",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 44.0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              6.0,
                            ),
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            nomorHandphone = value;
                          },
                          style: const TextStyle(),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Jenis Kelamin",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                activeColor: AppColor.primaryColor,
                                value: "Laki-laki",
                                groupValue: jenisKelamin,
                                onChanged: (value) {
                                  setState(() {
                                    jenisKelamin = value!;
                                  });
                                  log(jenisKelamin!);
                                },
                              ),
                              const Text(
                                "L",
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                activeColor: AppColor.primaryColor,
                                value: "Perempuan",
                                groupValue: jenisKelamin,
                                onChanged: (value) {
                                  setState(() {
                                    jenisKelamin = value!;
                                  });
                                  log(jenisKelamin!);
                                },
                              ),
                              const Text(
                                "P",
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Tanggal",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: QDatePicker(
                        label: "",
                        onChanged: (value) {
                          tanggalPendataan = value.millisecondsSinceEpoch;
                          log("$tanggalPendataan");
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Alamat",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 125.0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              6.0,
                            ),
                          ),
                        ),
                        child: TextField(
                          maxLines: 5,
                          onChanged: (value) {
                            alamatRumah = value;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(155, 40),
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: () {},
                      child: const Text("Cek Lokasi"),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Gambar",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              16.0,
                            ),
                          ),
                          onTap: () {
                            _pickImageGallery();
                          },
                          child: _selectedImage == null
                              ? Ink(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color:
                                        loading ? Colors.blueGrey[400] : null,
                                    image: loading
                                        ? null
                                        : DecorationImage(
                                            image: NetworkImage(
                                              imageUrl ??
                                                  "https://i.ibb.co/S32HNjD/no-image.jpg",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        16.0,
                                      ),
                                    ),
                                  ),
                                )
                              : Image.file(_selectedImage!)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      await DBPemilih.getAllPemilih();
                      var dataPemilih = PemilihModel(nik: nik);
                      await DBPemilih.isNikRegistered(dataPemilih.nik!).then(
                        (value) async {
                          value
                              ? AlertBannerWidgets.fail(
                                  context, 'NIK sudah terdaftar')
                              : await DBPemilih.createPemilih(
                                  nik: nik!,
                                  namaLengkap: namaLengkap!,
                                  nomorHandphone: nomorHandphone!,
                                  jenisKelamin: jenisKelamin!,
                                  tanggalPendataan: tanggalPendataan!,
                                  alamatRumah: alamatRumah!,
                                  gambar: gambar ??
                                      "https://i.ibb.co/S32HNjD/no-image.jpg",
                                ).then((value) => log(value.toString()));
                        },
                      );
                    },
                    child: const Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImage == null) return;
    setState(() {
      _selectedImage = File(returnImage.path);
    });
  }

  Future<void> _pickImageCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnImage == null) return;
    setState(() {
      _selectedImage = File(returnImage.path);
    });
  }
}
