import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

class DBMaster {
  //Inisialisasi Database SQL
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      join(await sql.getDatabasesPath(), 'pemilih.db'),
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTablePemilih(database);
      },
    );
  }

  //Membuat Tabel Pemilih
  static Future<void> createTablePemilih(sql.Database database) async {
    await database.execute(
      """CREATE TABLE dataPemilih(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nik INTEGER,
        namaLengkap TEXT,
        nomorHandphone TEXT,
        jenisKelamin TEXT,
        tanggalPendataan INTEGER,
        alamatRumah TEXT,
        gambar TEXT
      )
      """,
    );
  }

}
