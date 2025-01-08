import 'package:intl/intl.dart';

class MenuProductModel {
  final String nmProduk;
  final String hargaDijual;
  final String kodePabrik;
  final String jumlahStok;
  final String nmUnit;
  final DateTime tglKedaluwarsa;
  final String batchNomer;
  final String gambarPath;
  final String deskripsi;

  MenuProductModel({
    required this.nmProduk,
    required this.hargaDijual,
    required this.kodePabrik,
    required this.jumlahStok,
    required this.nmUnit,
    required this.tglKedaluwarsa,
    required this.batchNomer,
    required this.gambarPath,
    required this.deskripsi
  });

  factory MenuProductModel.fromJson(Map<String, dynamic> json) {
    return MenuProductModel(
      nmProduk: json['nmProduk'] ?? '',
      hargaDijual: _parseString(json['hargaDijual']),
      kodePabrik: json['kodePabrik'] ?? '',
      jumlahStok: _parseString(json['jumlahStok']),
      nmUnit: json['nmUnit'] ?? '',
      tglKedaluwarsa: DateFormat('yyyy-MM-dd').parse(json['tglKedaluwarsa'] ?? ''),
      batchNomer: json['batchNomer'] ?? '',
      gambarPath: json['gambarPath'] ?? '',
      deskripsi: json['deskripsi'] ?? ''
    );
  }

  static String _parseString(dynamic value) {
    if (value == null) {
      return '';
    }
    return value is int ? value.toString() : value.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'nmProduk': nmProduk,
      'hargaDijual': hargaDijual,
      'kodePabrik': kodePabrik,
      'jumlahStok': jumlahStok,
      'nmUnit': nmUnit,
      'tglKedaluwarsa': DateFormat('yyyy-MM-dd').format(tglKedaluwarsa),
      'batchNomer': batchNomer,
      'gambarPath': gambarPath,
      'deskripsi': deskripsi
    };
  }
}
