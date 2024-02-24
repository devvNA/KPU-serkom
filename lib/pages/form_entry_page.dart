// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, unused_field, unused_import

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serkom_kpu/model/pemilih_model.dart';
import 'package:serkom_kpu/pages/utils/app_colors.dart';
import 'package:serkom_kpu/pages/widget/alert_banner.dart';
import '../services/db_pemilih.dart';
import 'utils/validator.dart';
import 'widget/date_picker.dart';
import 'widget/file_image_picker.dart';

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
  String? gambar;
  String? jenisKelamin;
  int? tanggalPendataan;
  String? lokasi;
  File? _selectedImage;

  bool isLoading = false;

  Future<String> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    lokasi = position.toString();
    return lokasi!;
  }

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
                        backgroundColor: Colors.indigo,
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await getLocation().then((value) => {
                              showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Info'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text('$lokasi'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            alamatRumah.text = lokasi!;
                                          });
                                        },
                                        child: const Text("Ok"),
                                      ),
                                    ],
                                  );
                                },
                              )
                            });
                        isLoading = false;
                      },
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : const Text("Cek Lokasi"),
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
                      child: QImagePicker(
                        label: "",
                        validator: Validator.required,
                        onChanged: (value) {
                          gambar = value;
                          log(gambar!);
                        },
                      ),
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
                                    gambar: gambar!,
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

  // Future _pickImageGallery() async {
  //   final returnImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     _selectedImage = File(returnImage!.path);
  //     log(returnImage.name);
  //   });
  //   return returnImage;
  // }

  // Future _pickImageCamera() async {
  //   final returnImage =
  //       await ImagePicker().pickImage(source: ImageSource.camera);

  //   setState(() {
  //     _selectedImage = File(returnImage!.path);
  //     log(returnImage.name);
  //   });
  //   return returnImage;
  // }
}
