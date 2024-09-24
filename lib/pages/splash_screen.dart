// ignore_for_file: use_build_context_synchronously, unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serkom_kpu/pages/menu_page.dart';
import 'package:serkom_kpu/pages/utils/app_colors.dart';

import '../services/db_pemilih.dart';
import 'widget/alert_banner.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> loading() async {
      await Future.delayed(const Duration(milliseconds: 1500));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuPage()),
      );
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'KPU Mobile',
              style: GoogleFonts.pacifico(
                textStyle: const TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 30.0,
                ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            FutureBuilder(
              future: loading(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const CircularProgressIndicator();
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
