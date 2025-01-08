class Cart {
  String idCart;
  String idPesananPelanggan;
  String idMenuProduk;
  double hargaPerUnit;
  int jumlahUnit;
  double totalHarga;
  bool isOrderDetail;

  Cart({
    required this.idCart,
    required this.idPesananPelanggan,
    required this.idMenuProduk,
    required this.hargaPerUnit,
    required this.jumlahUnit,
    required this.totalHarga,
    required this.isOrderDetail
  });

  Map<String, dynamic> toMap() {
    return {
      'idCart': idCart,
      'idPesananPelanggan': idPesananPelanggan,
      'idMenuProduk': idMenuProduk,
      'hargaPerUnit': hargaPerUnit,
      'jumlahUnit': jumlahUnit,
      'totalHarga': totalHarga,
      'isOrderDetail': isOrderDetail
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      idCart: map['idCart'],
      idPesananPelanggan: map['idPesananPelanggan'],
      idMenuProduk: map['idMenuProduk'],
      hargaPerUnit: map['hargaPerUnit'],
      jumlahUnit: map['jumlahUnit'],
      totalHarga: map['totalHarga'],
      isOrderDetail: map['isOrderDetail']
    );
  }
}
