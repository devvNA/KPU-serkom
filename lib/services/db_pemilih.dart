import 'dart:developer';
import 'package:serkom_kpu/model/pemilih_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

import 'db_master.dart';

class DBPemilih {
  //Create data pemilih
  static Future<PemilihModel> createPemilih(
      {required int nik,
      required String namaLengkap,
      required String nomorHandphone,
      required String jenisKelamin,
      required String alamatRumah,
      required String gambar,
      required int tanggalPendataan}) async {
    final db = await DBMaster.db();

    final data = {
      "nik": nik,
      "namaLengkap": namaLengkap,
      "nomorHandphone": nomorHandphone,
      "jenisKelamin": jenisKelamin,
      "tanggalPendataan": tanggalPendataan,
      "alamatRumah": alamatRumah,
      "gambar": gambar,
    };
    final id = await db.insert(
      'dataPemilih',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return PemilihModel(
      id: id,
      nik: nik,
      namaLengkap: namaLengkap,
      nomorHandphone: nomorHandphone,
      jenisKelamin: jenisKelamin,
      tanggalPendataan: tanggalPendataan,
      alamatRumah: alamatRumah,
      gambar: gambar,
    );
  }

  // Read all data pemilih
  static Future<List<Map<String, dynamic>>> getAllPemilih() async {
    final db = await DBMaster.db();
    return db.query(
      'dataPemilih',
      orderBy: "id",
    );
  }

  // validasi duplikat data pemilih
  static Future<bool> isNikRegistered(int nik) async {
    final db = await DBMaster.db();
    final result = await db.query(
      'dataPemilih',
      where: 'nik = ?',
      whereArgs: [nik],
    );
    return result.isNotEmpty;
  }

  // Delete Database
  static Future<void> deletePemilih() async {
    final db = await DBMaster.db();
    try {
      await db.delete(
        "dataPemilih",
      );
    } catch (err) {
      log("Something went wrong when deleting an item: $err");
    }
  }
}
