import 'package:apps_sales/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/model/cart_model.dart';
import '../../data/model/menu_product_model.dart';
import '../../data/provider/cart_provider.dart';
import '../../utils/format.dart';
import '../../utils/shared_preferences.dart';
import '../widgets/widget_button_cart.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final MenuProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ValueNotifier<int> _jumlahUnitNotifier = ValueNotifier<int>(10);
  final ValueNotifier<int> _totalHargaNotifier = ValueNotifier<int>(0);
  late int daysRemaining;
  @override
  void initState() {
    super.initState();
    int hargaPerUnit = int.tryParse(widget.product.hargaDijual) ?? 0;
    _totalHargaNotifier.value = hargaPerUnit * _jumlahUnitNotifier.value;
    daysRemaining = calculateDaysRemaining(widget.product.tglKedaluwarsa.toString());
  }

  void _updateTotalHarga(int jumlah) {
    int hargaPerUnit = int.tryParse(widget.product.hargaDijual) ?? 0;
    _jumlahUnitNotifier.value = jumlah;
    _totalHargaNotifier.value = hargaPerUnit * jumlah;
  }

  @override
  void dispose() {
    _jumlahUnitNotifier.dispose();
    _totalHargaNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Text(
          'Rincian Produk',
          style: kHeading5.copyWith(
            color: kPrimaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kWhite,
        iconTheme: const IconThemeData(
          color: kPrimaryBlue,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.product.gambarPath),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, -4),
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 22),
                    Text(
                      formatCurrency(widget.product.hargaDijual),
                      style: kHeading5.copyWith(
                          fontWeight: FontWeight.bold, color: kPrimaryBlue),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            decoration: BoxDecoration(
                              color: kPrimaryBlue,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              widget.product.kodePabrik,
                              style: kBodyText.copyWith(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              widget.product.nmProduk,
                              style: kSubtitle.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                widget.product.deskripsi,
                                style: kSubtitle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Colors.black38,
                                ),
                                textAlign: TextAlign.justify,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Stok Sekarang',
                                style: kHeading6.copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "${widget.product.jumlahStok} (${widget.product.nmUnit})",
                                style: kSubtitle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  height: 1.8,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Batch Nomer',
                                style: kHeading6.copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "${widget.product.batchNomer} (${formatTanggal(widget.product.tglKedaluwarsa)})",
                                style: kSubtitle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  height: 1.8,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Exp.Date',
                                style: kHeading6.copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "${formatTanggal(widget.product.tglKedaluwarsa)} - Sisa $daysRemaining hari",
                                style: kSubtitle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  height: 1.8,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CartButton(
                      onPressed: () async {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                color: kWhite,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 4,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: kPrimaryBlue,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.4,
                                          height: MediaQuery.of(context).size.height * 0.2,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(widget.product.gambarPath),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 24),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 40),
                                            Text(
                                              formatCurrency(widget.product.hargaDijual),
                                              style: kHeading5.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryBlue,
                                              ),
                                            ),
                                            Text(
                                              "Stok: ${widget.product.jumlahStok} (${widget.product.nmUnit})",
                                              style: kSubtitle.copyWith(
                                                fontWeight: FontWeight.w500,
                                                height: 1.8,
                                                color: Colors.black38,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Jumlah:",
                                          style: kHeading6.copyWith(fontWeight: FontWeight.normal),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: () {
                                                if (_jumlahUnitNotifier.value > 1) {
                                                  _updateTotalHarga(_jumlahUnitNotifier.value - 1);
                                                }
                                              },
                                            ),
                                            ValueListenableBuilder<int>(
                                              valueListenable: _jumlahUnitNotifier,
                                              builder: (context, jumlah, _) {
                                                return Text(
                                                  '$jumlah',
                                                  style: kHeading6.copyWith(fontWeight: FontWeight.bold),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: () {
                                                int stok = int.tryParse(widget.product.jumlahStok) ?? 0;
                                                if (_jumlahUnitNotifier.value < stok) {
                                                  _updateTotalHarga(_jumlahUnitNotifier.value + 5);
                                                }
                                              },
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                _jumlahUnitNotifier.value = 1;
                                                _updateTotalHarga(1);
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                              ),
                                              child: Text(
                                                'Reset',
                                                style: kBodyText.copyWith(fontWeight: FontWeight.bold, color: kPrimaryBlue),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ValueListenableBuilder<int>(
                                          valueListenable: _totalHargaNotifier,
                                          builder: (context, totalHarga, _) {
                                            return Text(
                                              'Total Harga: ${formatCurrency(totalHarga.toString())}',
                                              style: kSubtitle.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryBlue,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    CartButton(
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => const Center(child: CircularProgressIndicator()),
                                        );

                                        try {
                                          int hargaPerUnit = int.tryParse(widget.product.hargaDijual) ?? 0;
                                          final userId =  await SharedPrefHelper.getUserId();
                                          final cart = Cart(
                                            idCart: UniqueKey().toString(),
                                            idUser: userId.toString(),
                                            idMenuProduk: widget.product.idMenuProduk,
                                            hargaPerUnit: hargaPerUnit,
                                            jumlahUnit: _jumlahUnitNotifier.value,
                                            totalHarga: (_jumlahUnitNotifier.value * hargaPerUnit),
                                            gambarPath: widget.product.gambarPath,
                                            nmProduk: widget.product.nmProduk,
                                            deskripsi: widget.product.deskripsi,
                                            nmUnit: widget.product.nmUnit,
                                            kodePabrik: widget.product.kodePabrik,
                                            isOrderDetail: false,
                                          );

                                          await Provider.of<CartProvider>(context, listen: false).addCart(cart);
                                          Navigator.of(context).pop();

                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => const CartScreen()),
                                          );
                                        } catch (e) {
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Gagal menambah ke keranjang: $e')),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
