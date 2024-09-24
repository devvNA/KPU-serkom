// ignore_for_file: must_be_immutable
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
        title: Text("Informasi",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pemantauan Real Count Pemilu 2024",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    text:
                        'Setelah hasil quick count Pemilu 2024 diumumkan, warga RI kini menunggu data real count yang dikumpulkan oleh KPU. Anda dapat memantau langsung pergerakan real time data real count di ',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16.0,
                        height: 1.5,
                      ),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = onLaunchUrl,
                        text: 'website resmi KPU',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Proses perhitungan suara Pemilu 2024 akan berlangsung selama dua hari, dari 14 hingga 15 Februari 2024, sesuai dengan Peraturan KPU RI Nomor 3 Tahun 2022.",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: Colors.blue.shade900,
                        fontSize: 15.0,
                        height: 1.5,
                      ),
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
