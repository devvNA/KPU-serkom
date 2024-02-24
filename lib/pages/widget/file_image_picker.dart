// ignore_for_file: constant_identifier_names, unused_element
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serkom_kpu/pages/utils/app_colors.dart';

const String _CLOUDINARY_CLOUD_NAME = "dotz74j1p";
const String _CLOUDINARY_API_KEY = "983354314759691";
const String _CLOUDINARY_UPLOAD_PRESET = "yogjjkoh";

class QImagePicker extends StatefulWidget {
  final String label;
  final String? value;
  final String? hint;
  final String? helper;
  final String? Function(String?)? validator;
  final Function(String) onChanged;
  final List<String> extensions;
  final bool enabled;

  const QImagePicker({
    Key? key,
    required this.label,
    this.value,
    this.validator,
    this.hint,
    this.helper,
    required this.onChanged,
    this.extensions = const ["jpg", "png"],
    this.enabled = true,
  }) : super(key: key);

  @override
  State<QImagePicker> createState() => _QImagePickerState();
}

class _QImagePickerState extends State<QImagePicker> {
  String? imageUrl;
  bool loading = false;
  late TextEditingController controller;

  @override
  void initState() {
    imageUrl = widget.value;
    controller = TextEditingController(
      text: widget.value ?? "-",
    );
    super.initState();
  }

  Future<String?> getFileMultiplePlatform() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: widget.extensions,
      allowMultiple: false,
    );
    if (result == null) return null;
    return result.files.first.path;
  }

  Future<String?> getFileAndroidIosAndWeb() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
    String? filePath = image?.path;
    if (filePath == null) return null;
    return filePath;
  }

  Future<String?> getFileAndroidIosAndWebCamera() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    String? filePath = image?.path;
    if (filePath == null) return null;
    return filePath;
  }

  Future<String> uploadToCloudinary(String filePath) async {
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        File(filePath).readAsBytesSync(),
        filename: "upload.jpg",
      ),
      'upload_preset': _CLOUDINARY_UPLOAD_PRESET,
      'api_key': _CLOUDINARY_API_KEY,
    });

    var res = await Dio().post(
      'https://api.cloudinary.com/v1_1/_CLOUDINARY_CLOUD_NAME/image/upload',
      data: formData,
    );

    String url = res.data["secure_url"];
    return url;
  }

  browseFile() async {
    if (loading) return;

    String? filePath;
    setState(() {});

    if (!kIsWeb && Platform.isWindows) {
      filePath = await getFileMultiplePlatform();
    } else {
      filePath = await getFileAndroidIosAndWeb();
    }
    if (filePath == null) return;

    loading = true;
    setState(() {});

    imageUrl = await uploadToCloudinary(filePath);

    loading = false;
    setState(() {});

    if (imageUrl != null) {
      widget.onChanged(imageUrl!);
      controller.text = imageUrl!;
    }
    setState(() {});
  }

  cameraFile() async {
    if (loading) return;

    String? filePath;
    setState(() {});

    if (!kIsWeb && Platform.isWindows) {
      filePath = await getFileMultiplePlatform();
    } else {
      filePath = await getFileAndroidIosAndWebCamera();
    }
    if (filePath == null) return;

    loading = true;
    setState(() {});

    imageUrl = await uploadToCloudinary(filePath);

    loading = false;
    setState(() {});

    if (imageUrl != null) {
      widget.onChanged(imageUrl!);
      controller.text = imageUrl!;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      margin: const EdgeInsets.only(
        bottom: 12.0,
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            6.0,
          ),
        ),
        onTap: () async {
          showModalBottomSheet(
              backgroundColor: Colors.grey[200],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Tombol camera
                      ElevatedButton.icon(
                          onPressed: () => cameraFile(),
                          icon: const Icon(Icons.camera_alt_sharp),
                          label: const Text("Kamera")),

                      // Tombol galeri
                      ElevatedButton.icon(
                        onPressed: () => browseFile(),
                        icon: const Icon(Icons.photo),
                        label: const Text("Galeri"),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.blueGrey[200],
            image: loading
                ? null
                : DecorationImage(
                    image: NetworkImage(
                      imageUrl == null
                          ? "https://i.ibb.co/S32HNjD/no-image.jpg"
                          : imageUrl!,
                    ),
                    fit: BoxFit.cover,
                  ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                6.0,
              ),
            ),
          ),
          child: Visibility(
            visible: loading == true,
            child: const SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    "Uploading...",
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Ink(
        //   height: 200,
        //   decoration: BoxDecoration(
        //     color: Colors.blueGrey[200],
        //     image: loading
        //         ? null
        //         : DecorationImage(
        //             image: NetworkImage(
        //               imageUrl == null
        //                   ? "https://i.ibb.co/S32HNjD/no-image.jpg"
        //                   : imageUrl!,
        //             ),
        //             fit: BoxFit.cover,
        //           ),
        //     borderRadius: const BorderRadius.all(
        //       Radius.circular(
        //         6.0,
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
