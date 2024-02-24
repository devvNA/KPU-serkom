import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class InformasiPage extends StatelessWidget {
  InformasiPage({super.key});

  final Uri url = Uri.parse('https://pemilu2024.kpu.go.id/');

  Future<void> onLaunchUrl() async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informasi"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text:
                        'Setelah hasil quick count Pemilu 2024 diumumkan kemarin, warga RI kini menunggu data real count yang dikumpulkan oleh KPU. Penduduk Indonesia bisa memantau langsung pergerakan real time data real count di website resmi KPU. Data real time KPU bisa dipantau di website resmi KPU di alamat',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            onLaunchUrl();
                          },
                        text: ' https://pemilu2024.kpu.go.id/',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Sebagai informasi, proses perhitungan suara Pemilu 2024 akan berlangsung selama dua hari. Hal tersebut sejalan dengan Peraturan KPU RI Nomor 3 Tahun 2022 tentang Tahapan dan Jadwal Penyelenggaraan Pemilihan Umum Tahun 2024 bahwa proses perhitungan suara akan berlangsung pada hari Rabu, 14 Februari 2024 hingga Kamis, 15 Februari 2024.",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
