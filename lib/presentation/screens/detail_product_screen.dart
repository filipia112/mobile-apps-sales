import 'package:apps_sales/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/model/menu_product_model.dart';
import '../../utils/format_currency.dart';

class ProductDetailScreen extends StatelessWidget {
  final MenuProductModel product;
  const ProductDetailScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(title: const Text('Detail Produk'),
      backgroundColor: kWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.gambarPath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, size: 200),
            ),
            const SizedBox(height: 16),
            Text(
              product.nmProduk,
              style: kHeading6,
            ),
            Text(
              "Pabrik: ${product.kodePabrik}",
              style: kSubtitle,
            ),
            const SizedBox(height: 8),
            Text(
              "Harga: ${formatCurrency(product.hargaDijual)}",
              style: kHeading6.copyWith(color: Colors.blue),
            ),
            const SizedBox(height: 8),
            Text(
              "Stok: ${product.jumlahStok}",
              style: kSubtitle,
            ),
            const SizedBox(height: 8),
            Text(
              "Unit: ${product.nmUnit}",
              style: kSubtitle,
            ),
            const SizedBox(height: 8),
            Text(
              "Kedaluwarsa: ${DateFormat('yyyy-MM-dd').format(product.tglKedaluwarsa)}",
              style: kSubtitle,
            ),
            const SizedBox(height: 8),
            Text(
              "Batch: ${product.batchNomer}",
              style: kSubtitle,
            ),
          ],
        ),
      ),
    );
  }
}
