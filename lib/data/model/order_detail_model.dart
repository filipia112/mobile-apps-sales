import 'dart:convert';

class OrderDetail {
  final String idPesananPelanggan;
  final String idMenuProduk;
  final String jumlahUnit;
  final String hargaPerunit;
  final String totalHarga;

  OrderDetail({
    required this.idPesananPelanggan,
    required this.idMenuProduk,
    required this.jumlahUnit,
    required this.hargaPerunit,
    required this.totalHarga
  });

  Map<String, String> toJson(){
    return {
      'IdPesananPelanggan' : idPesananPelanggan,
      'IdMenuProduk': idMenuProduk,
      'jumlahUnit': jumlahUnit,
      'hargaPerunit': hargaPerunit,
      'totalHarga': totalHarga
    };
  }
  String toJsonString() => jsonEncode(toJson());
}