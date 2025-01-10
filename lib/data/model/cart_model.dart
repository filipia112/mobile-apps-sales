class Cart {
  String idCart;
  String idMenuProduk;
  int hargaPerUnit;
  int jumlahUnit;
  int totalHarga;
  String gambarPath;
  String nmProduk;
  String deskripsi;
  String nmUnit;
  String kodePabrik;
  bool isOrderDetail;

  Cart({
    required this.idCart,
    required this.idMenuProduk,
    required this.hargaPerUnit,
    required this.jumlahUnit,
    required this.totalHarga,
    required this.gambarPath,
    required this.nmProduk,
    required this.deskripsi,
    required this.nmUnit,
    required this.kodePabrik,
    required this.isOrderDetail
  });
  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      idCart: map['idCart'],
      idMenuProduk: map['idMenuProduk'],
      hargaPerUnit: map['hargaPerUnit'],
      jumlahUnit: map['jumlahUnit'],
      totalHarga: map['totalHarga'],
      gambarPath: map['gambarPath'],
      nmProduk: map['nmProduk'],
      deskripsi: map['deskripsi'],
      nmUnit: map['nmUnit'],
      kodePabrik: map['kodePabrik'],
      isOrderDetail: map['isOrderDetail'] == 1,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'idCart': idCart,
      'idMenuProduk': idMenuProduk,
      'hargaPerUnit': hargaPerUnit,
      'jumlahUnit': jumlahUnit,
      'totalHarga': totalHarga,
      'gambarPath': gambarPath,
      'nmProduk': nmProduk,
      'deskripsi': deskripsi,
      'nmUnit': nmUnit,
      'kodePabrik': kodePabrik,
      'isOrderDetail': isOrderDetail ? 1 : 0,
    };
  }
}
