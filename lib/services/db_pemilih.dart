import 'dart:developer';

import 'package:serkom_kpu/model/pemilih_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

import 'db_master.dart';

class DBPemilih {
  static const String _tableName = 'dataPemilih';

  static Future<PemilihModel> createPemilih(PemilihModel pemilih) async {
    final db = await DBMaster.db();
    final id = await db.insert(
      _tableName,
      pemilih.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return pemilih.copyWith(id: id);
  }

  static Future<List<PemilihModel>> getAllPemilih() async {
    final db = await DBMaster.db();
    final maps = await db.query(_tableName, orderBy: "id");
    return maps.map((map) => PemilihModel.fromMap(map)).toList();
  }

  static Future<bool> isNikRegistered(int nik) async {
    final db = await DBMaster.db();
    final result = await db.query(
      _tableName,
      where: 'nik = ?',
      whereArgs: [nik],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  static Future<void> deletePemilih() async {
    final db = await DBMaster.db();
    try {
      await db.delete(_tableName);
    } catch (err) {
      log("Terjadi kesalahan saat menghapus semua data: $err");
    }
  }

  static Future<void> deleteData({required int id}) async {
    final db = await DBMaster.db();
    try {
      await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
      log("Data berhasil dihapus");
    } catch (err) {
      log("Terjadi kesalahan saat menghapus item: $err");
    }
  }
}
