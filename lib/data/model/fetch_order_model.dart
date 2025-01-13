class FetchOrder {
  final String idPesananPelanggan;
  final String idPelanggan;
  final String idUser;
  final String nmPelanggan;
  final String noPelanggan;
  final String noPesanan;
  final String keterangan;
  final bool isVerified;
  final String nmUser;
  final DateTime dibuat;

  FetchOrder({
    required this.idPesananPelanggan,
    required this.idPelanggan,
    required this.idUser,
    required this.nmPelanggan,
    required this.noPelanggan,
    required this.noPesanan,
    required this.keterangan,
    required this.isVerified,
    required this.nmUser,
    required this.dibuat,
  });

  factory FetchOrder.fromJson(Map<String, dynamic> json) {
    return FetchOrder(
      idPesananPelanggan: json['IdPesananPelanggan'] ?? 'Unknown',
      idPelanggan: json['IdPelanggan'] ?? 'Unknown',
      idUser: json['IdUser'] ?? 'Unknown',
      nmPelanggan: json['nmPelanggan'] ?? 'Unknown',
      noPelanggan: json['noPelanggan'] ?? 'Unknown',
      noPesanan: json['noPesanan'] ?? 'Unknown',
      keterangan: json['keterangan'] ?? 'Unknown',
      isVerified: json['isVerified'] == 1,
      nmUser: json['nmUser'] ?? 'Unknown',
      dibuat: DateTime.tryParse(json['dibuat'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'IdPesananPelanggan': idPesananPelanggan,
      'IdPelanggan': idPelanggan,
      'IdUser': idUser,
      'nmPelanggan': nmPelanggan,
      'noPelanggan': noPelanggan,
      'noPesanan': noPesanan,
      'keterangan': keterangan,
      'isVerified': isVerified ? 1 : 0,
      'nmUser': nmUser,
      'dibuat': dibuat.toIso8601String(),
    };
  }
}
