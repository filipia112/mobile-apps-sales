import 'dart:convert';

class Order {
  final String idUser;
  final String idPelanggan;
  final String noPesanan;
  final String keterangan;

  Order({
    required this.idUser,
    required this.idPelanggan,
    required this.noPesanan,
    required this.keterangan
  });

  Map<String, String> toJson() {
    return {
      'IdUser': idUser,
      'IdPelanggan': idPelanggan,
      'noPesanan': noPesanan,
      'keterangan': keterangan
    };
  }

  String toJsonString() => jsonEncode(toJson());
}