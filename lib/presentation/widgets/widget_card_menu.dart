import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/model/menu_product_model.dart';
import '../../data/provider/menu_product_provider.dart';
import '../../utils/format_currency.dart';
import '../screens/detail_product_screen.dart';
class ProductList extends StatelessWidget {
  final bool isAll;
  const ProductList({super.key, required this.isAll});
  @override
  Widget build(BuildContext context) {
    var menuProductProvider = Provider.of<MenuProductProvider>(context);
    if (menuProductProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (menuProductProvider.errorMessage != null) {
      return Center(
        child: Text(menuProductProvider.errorMessage!),
      );
    }

    List<MenuProductModel> displayedProducts = isAll
        ? menuProductProvider.filteredProducts
        : (menuProductProvider.filteredProducts.take(4).toList());

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: (displayedProducts.length / 2).ceil(),
      itemBuilder: (context, index) {
        var firstProductIndex = index * 2;
        var secondProductIndex = firstProductIndex + 1;
        var firstProduct = displayedProducts[firstProductIndex];
        var secondProduct = secondProductIndex < displayedProducts.length
            ? displayedProducts[secondProductIndex]
            : null;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ProductCard(
                  imageUrl: firstProduct.gambarPath,
                  productName: firstProduct.nmProduk,
                  productPrice: firstProduct.hargaDijual,
                  factoryName: firstProduct.kodePabrik,
                  totalStock: firstProduct.jumlahStok.toString(),
                  product: firstProduct,
                ),
              ),
              const SizedBox(width: 8),
              if (secondProduct != null)
                Expanded(
                  child: ProductCard(
                    imageUrl: secondProduct.gambarPath,
                    productName: secondProduct.nmProduk,
                    productPrice: secondProduct.hargaDijual,
                    factoryName: secondProduct.kodePabrik,
                    totalStock: secondProduct.jumlahStok.toString(),
                    product: secondProduct,
                  ),
                ),
              if (secondProduct == null) Expanded(child: Container()),
            ],
          ),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String factoryName;
  final String productPrice;
  final String totalStock;
  final MenuProductModel product;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.factoryName,
    required this.productPrice,
    required this.totalStock,
    required this.product,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              product: product,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 150),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          factoryName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          productName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatCurrency(productPrice),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      totalStock,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
