import 'package:apps_sales/common/constants.dart';
import 'package:flutter/material.dart';
class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String factoryName;
  final String productPrice;
  final String totalStock;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.factoryName,
    required this.productPrice,
    required this.totalStock
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kOffWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
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
                        style: kBodyText.copyWith(color: kLightGrey),
                      ),
                    ),
                    Text(
                      totalStock.toString(), // Menampilkan totalStock
                      style: kHeading6.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: kPrimaryBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: kHeading6.copyWith(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  productPrice,
                  style: kHeading6.copyWith(
                    color: kPrimaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class ProductList extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'productName': 'Produk 1',
      'stok': '40',
      'pabrik': 'MARIN',
      'productPrice': 'Rp 100.000',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'productName': 'Produk 2',
      'stok': '40',
      'pabrik': 'Otsuka',
      'productPrice': 'Rp 150.000',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'productName': 'Produk 3',
      'stok': '40',
      'pabrik': 'Otsuka',
      'productPrice': 'Rp 200.000',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'productName': 'Produk 4',
      'stok': '40',
      'pabrik': 'Otsuka',
      'productPrice': 'Rp 250.000',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'productName': 'Produk 5',
      'stok': '40',
      'pabrik': 'Otsuka',
      'productPrice': 'Rp 250.000',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'productName': 'Produk 6',
      'stok': '40',
      'pabrik': 'PIM',
      'productPrice': 'Rp 250.000',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'productName': 'Produk 7',
      'stok': '40',
      'pabrik': 'PIM',
      'productPrice': 'Rp 250.000',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'productName': 'Produk 8',
      'stok': '40',
      'pabrik': 'PIM',
      'productPrice': 'Rp 250.000',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'productName': 'Produk 9',
      'stok': '40',
      'pabrik': 'PIM',
      'productPrice': 'Rp 250.000',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'productName': 'Produk 10',
      'stok': '40',
      'pabrik': 'PIM',
      'productPrice': 'Rp 250.000',
    },
  ];

  final bool isAll;

  ProductList({Key? key, this.isAll = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> displayedProducts = isAll ? products : products.take(4).toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: (displayedProducts.length / 2).ceil(),
      itemBuilder: (context, index) {
        int firstIndex = index * 2;
        int secondIndex = firstIndex + 1;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                  child: ProductCard(
                    imageUrl: displayedProducts[firstIndex]['imageUrl']!,
                    productName: displayedProducts[firstIndex]['productName']!,
                    productPrice: displayedProducts[firstIndex]['productPrice']!,
                    factoryName: displayedProducts[firstIndex]['pabrik']!,
                    totalStock: displayedProducts[secondIndex]['stok']!,
                  ),
              ),
              const SizedBox(width: 4),
              if (secondIndex < displayedProducts.length)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                    child: ProductCard(
                      imageUrl: displayedProducts[secondIndex]['imageUrl']!,
                      productName: displayedProducts[secondIndex]['productName']!,
                      productPrice: displayedProducts[secondIndex]['productPrice']!,
                      factoryName: displayedProducts[secondIndex]['pabrik']!,
                      totalStock: displayedProducts[secondIndex]['stok']!,
                    ),
                ),
            ],
          ),
        );
      },
    );
  }
}
