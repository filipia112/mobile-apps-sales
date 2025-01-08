import 'package:apps_sales/common/constants.dart';
import 'package:flutter/material.dart';
import '../../data/model/menu_product_model.dart';
import '../../utils/format.dart';
import '../widgets/widget_button_cart.dart';

class ProductDetailScreen extends StatelessWidget {
  final MenuProductModel product;
  const ProductDetailScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOffWhite,
      appBar: AppBar(
        title: Text('Detail Produk',
          style: kHeading5.copyWith(fontWeight: FontWeight.bold, color: kWhite),
        ),
        backgroundColor: kPrimaryBlue,
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.gambarPath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height:28),
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
                        formatCurrency(product.hargaDijual),
                        style: kHeading5.copyWith(fontWeight: FontWeight.bold, color: kPrimaryBlue),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                              decoration: BoxDecoration(
                                color: kPrimaryBlue,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.blueAccent,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                product.kodePabrik,
                                style: kBodyText.copyWith(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                product.nmProduk,
                                style: kSubtitle.copyWith(fontWeight: FontWeight.normal,
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
                                  product.deskripsi,
                                  style: kSubtitle.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    height: 1.5,
                                    color: Colors.black38
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
                                  style: kHeading6.copyWith(color: Colors.black54, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "${product.jumlahStok} (${product.nmUnit})",
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
                                  style: kHeading6.copyWith(color: Colors.black54, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "${product.batchNomer} (${formatTanggal(product.tglKedaluwarsa)})",
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
                        onPressed: () {
                         print("Mantap");
                        },
                      ),
                      const SizedBox(height:28),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
// Text(
// "Kedaluwarsa: ${DateFormat('yyyy-MM-dd').format(product.tglKedaluwarsa)}",
// style: kSubtitle.copyWith(color: Colors.black54),
// ),