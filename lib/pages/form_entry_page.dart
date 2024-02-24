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
  TextEditingController nik = TextEditingController();
  TextEditingController namaLengkap = TextEditingController();
  TextEditingController nomorHandphone = TextEditingController();
  TextEditingController alamatRumah = TextEditingController();
  TextEditingController gambar = TextEditingController();
  String? jenisKelamin;
  int? tanggalPendataan;
  File? _selectedImage;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Entry"),
        centerTitle: true,
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
                            controller: nik,
                            onChanged: (value) {
                              nik.text = value;
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
                          controller: namaLengkap,
                          onChanged: (value) {
                            namaLengkap.text = value;
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
                          controller: nomorHandphone,
                          onChanged: (value) {
                            nomorHandphone.text = value;
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
                          controller: alamatRumah,
                          maxLines: 5,
                          onChanged: (value) {
                            alamatRumah.text = value;
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
                      child: _selectedImage == null
                          ? InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  6.0,
                                ),
                              ),
                              onTap: () {
                                _pickImageGallery();
                              },
                              child: Ink(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[400],
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/no-image.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      6.0,
                                    ),
                                  ),
                                ),
                              ))
                          : InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  6.0,
                                ),
                              ),
                              onTap: () {
                                _pickImageGallery();
                              },
                              child: Ink(
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[400],
                                  image: DecorationImage(
                                    image: FileImage(_selectedImage!),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      6.0,
                                    ),
                                  ),
                                ),
                              )),
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
                      try {
                        var dataPemilih =
                            PemilihModel(nik: int.parse(nik.text));
                        await DBPemilih.isNikRegistered(dataPemilih.nik!).then(
                          (value) async {
                            value
                                ? AlertBannerWidgets.fail(
                                    context, 'NIK sudah terdaftar')
                                : await DBPemilih.createPemilih(
                                    nik: int.parse(nik.text),
                                    namaLengkap: namaLengkap.text,
                                    nomorHandphone: nomorHandphone.text,
                                    jenisKelamin: jenisKelamin!,
                                    tanggalPendataan: tanggalPendataan!,
                                    alamatRumah: alamatRumah.text,
                                    gambar: gambar.text,
                                  ).then((value) => log(value.toString())).then(
                                    (value) => AlertBannerWidgets.success(
                                        context, "Sukses Input"));
                          },
                        );
                        Future.delayed(const Duration(milliseconds: 800))
                            .then((value) {
                          setState(() {
                            namaLengkap.clear();
                            nomorHandphone.clear();
                            alamatRumah.clear();
                            jenisKelamin = "";
                            alamatRumah.clear();
                          });
                        });
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        AlertBannerWidgets.fail(context, "Gagal Input");
                      }
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

  Future<XFile?> _pickImageGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = File(returnImage!.path);
      log(returnImage.name);
    });
    return returnImage;
  }

  Future<XFile?> _pickImageCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _selectedImage = File(returnImage!.path);
      log(returnImage.name);
    });
    return returnImage;
  }
}
