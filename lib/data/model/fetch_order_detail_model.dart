class FetchOrderDetail {
  final String noPesanan;
  final String nmPelanggan;
  final String nmProduk;
  final String nmPabrik;
  final String nmUnit;
  final String batchNomer;
  final int hargaPerUnit;
  final int jumlahUnit;
  final int totalHarga;
  final bool isShip;

  FetchOrderDetail({
    required this.noPesanan,
    required this.nmPelanggan,
    required this.nmProduk,
    required this.nmPabrik,
    required this.nmUnit,
    required this.batchNomer,
    required this.hargaPerUnit,
    required this.jumlahUnit,
    required this.totalHarga,
    required this.isShip,
  });

  factory FetchOrderDetail.fromJson(Map<String, dynamic> json) {
    return FetchOrderDetail(
      noPesanan: json['noPesanan'] ?? 'Unknown',
      nmPelanggan: json['nmPelanggan'] ?? 'Unknown',
      nmProduk: json['nmProduk'] ?? 'Unknown',
      nmPabrik: json['nmPabrik'] ?? 'Unknown',
      nmUnit: json['nmUnit'] ?? 'Unknown',
      batchNomer: json['batchNomer'] ?? 'Unknown',
      hargaPerUnit: json['hargaPerUnit'] ?? 0,
      jumlahUnit: json['jumlahUnit'] ?? 0,
      totalHarga: json['totalHarga'] ?? 0,
      isShip: json['isShip'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noPesanan': noPesanan,
      'nmPelanggan': nmPelanggan,
      'nmProduk': nmProduk,
      'nmPabrik': nmPabrik,
      'nmUnit': nmUnit,
      'batchNomer': batchNomer,
      'hargaPerUnit': hargaPerUnit,
      'jumlahUnit': jumlahUnit,
      'totalHarga': totalHarga,
      'isShip': isShip ? 1 : 0,
    };
  }
}
