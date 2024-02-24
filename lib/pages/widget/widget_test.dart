import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<String?> getFileAndroidIosAndWeb() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
    String? filePath = image?.path;
    return filePath;
  }

  String? get currentValue {
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      margin: const EdgeInsets.only(
        bottom: 12.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 96.0,
            width: 96.0,
            margin: const EdgeInsets.only(
              top: 8.0,
            ),
            decoration: BoxDecoration(
              color: loading ? Colors.blueGrey[400] : null,
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
                  16.0,
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
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "Uploading...",
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: FormField(
                initialValue: false,
                validator: (value) {
                  return widget.validator!(imageUrl);
                },
                enabled: true,
                builder: (FormFieldState<bool> field) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: widget.label,
                            labelStyle: const TextStyle(
                              color: Colors.blueGrey,
                            ),
                            helperText: widget.helper,
                            hintText: widget.hint,
                            errorText: field.errorText,
                          ),
                          onChanged: (value) {
                            widget.onChanged(value);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      if (widget.enabled)
                        Container(
                          width: 50.0,
                          height: 46.0,
                          margin: const EdgeInsets.only(
                            right: 4.0,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(0.0),
                              backgroundColor: Colors.grey[500],
                            ),
                            onPressed: () => getFileAndroidIosAndWeb(),
                            child: const Icon(
                              Icons.file_upload,
                              size: 24.0,
                            ),
                          ),
                        ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
