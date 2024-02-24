import 'dart:convert';

class PemilihModel {
  int? id;
  int? nik;
  String? namaLengkap;
  String? nomorHandphone;
  String? jenisKelamin;
  int? tanggalPendataan;
  String? alamatRumah;
  String? gambar;

  PemilihModel({
    this.id,
    this.nik,
    this.namaLengkap,
    this.nomorHandphone,
    this.jenisKelamin,
    this.tanggalPendataan,
    this.alamatRumah,
    this.gambar,
  });

  PemilihModel copyWith({
    int? id,
    int? nik,
    String? namaLengkap,
    String? nomorHandphone,
    String? jenisKelamin,
    int? tanggalPendataan,
    String? alamatRumah,
    String? gambar,
  }) {
    return PemilihModel(
      id: id ?? this.id,
      nik: nik ?? this.nik,
      namaLengkap: namaLengkap ?? this.namaLengkap,
      nomorHandphone: nomorHandphone ?? this.nomorHandphone,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      tanggalPendataan: tanggalPendataan ?? this.tanggalPendataan,
      alamatRumah: alamatRumah ?? this.alamatRumah,
      gambar: gambar ?? this.gambar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nik': nik,
      'namaLengkap': namaLengkap,
      'nomorHandphone': nomorHandphone,
      'jenisKelamin': jenisKelamin,
      'tanggalPendataan': tanggalPendataan,
      'alamatRumah': alamatRumah,
      'gambar': gambar,
    };
  }

  factory PemilihModel.fromMap(Map<String, dynamic> map) {
    return PemilihModel(
      id: map['id']?.toInt() ?? 0,
      nik: map['nik']?.toInt() ?? 0,
      namaLengkap: map['namaLengkap'] ?? '',
      nomorHandphone: map['nomorHandphone'] ?? '',
      jenisKelamin: map['jenisKelamin'] ?? '',
      tanggalPendataan: map['tanggalPendataan']?.toInt() ?? 0,
      alamatRumah: map['alamatRumah'] ?? '',
      gambar: map['gambar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PemilihModel.fromJson(String source) =>
      PemilihModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PemilihModel(id: $id, nik: $nik, namaLengkap: $namaLengkap, nomorHandphone: $nomorHandphone, jenisKelamin: $jenisKelamin, tanggalPendataan: $tanggalPendataan, alamatRumah: $alamatRumah, gambar: $gambar)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PemilihModel &&
        other.id == id &&
        other.nik == nik &&
        other.namaLengkap == namaLengkap &&
        other.nomorHandphone == nomorHandphone &&
        other.jenisKelamin == jenisKelamin &&
        other.tanggalPendataan == tanggalPendataan &&
        other.alamatRumah == alamatRumah &&
        other.gambar == gambar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nik.hashCode ^
        namaLengkap.hashCode ^
        nomorHandphone.hashCode ^
        jenisKelamin.hashCode ^
        tanggalPendataan.hashCode ^
        alamatRumah.hashCode ^
        gambar.hashCode;
  }
}
