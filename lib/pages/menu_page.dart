import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serkom_kpu/pages/form_entry_page.dart';
import 'package:serkom_kpu/pages/information_page.dart';
import 'package:serkom_kpu/pages/lihat_data_page.dart';
import 'package:serkom_kpu/pages/utils/app_colors.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beranda"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColor.backgroundColor,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primaryColor.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Image.asset(
                  "assets/images/kpu-logo.png",
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "KPU - Mobile",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ButtonMenu(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InformasiPage(),
                    ),
                  );
                },
                title: "Informasi",
                color: AppColor.secondaryColor,
              ),
              ButtonMenu(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FormEntryPage()),
                  );
                },
                title: "Form Entry",
                color: AppColor.accentColor,
              ),
              ButtonMenu(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LihatDataPage()),
                  );
                },
                title: "Lihat Data",
                color: AppColor.secondaryColor,
              ),
              ButtonMenu(
                onTap: () {
                  SystemNavigator.pop();
                },
                title: "Keluar",
                color: Colors.red.shade400,
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonMenu extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color color;

  const ButtonMenu({
    super.key,
    required this.onTap,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
