import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:serkom_kpu/pages/form_entry_page.dart';
import 'package:serkom_kpu/pages/information_page.dart';
import 'package:serkom_kpu/pages/lihat_data_page.dart';
import 'widget/button_menu.dart';

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
          title: const Text("Menu"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/kpu-logo.png",
                width: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                "KPU - Mobile",
                style: GoogleFonts.racingSansOne(
                  textStyle: const TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
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
              ),
              const SizedBox(
                height: 15.0,
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
              ),
              const SizedBox(
                height: 15.0,
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
              ),
              const SizedBox(
                height: 15.0,
              ),
              ButtonMenu(
                onTap: () {
                  SystemNavigator.pop();
                },
                title: "Keluar",
              ),
              const SizedBox(width: 20),
            ],
          ),
        ));
  }
}
