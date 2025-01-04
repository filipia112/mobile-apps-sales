import 'package:apps_sales/common/constants.dart';
import 'package:flutter/material.dart';
class OrderCard extends StatelessWidget {
  final String nameCustomer;
  final String imageUrl;
  final String productName;
  final String namePabrik;
  final String batchNomer;
  final String totalPrice;

  const OrderCard({
    Key? key,
    required this.nameCustomer,
    required this.imageUrl,
    required this.productName,
    required this.namePabrik,
    required this.batchNomer,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kOffWhite,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nameCustomer,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kBodyText.copyWith(color: kLightGrey),
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    namePabrik,
                    style: kHeading6.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: kHeading6.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    totalPrice,
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
      ),
    );
  }
}
class OrderList extends StatelessWidget {
  final List<Map<String, String>> orders = [
    {
      'nameCustomer': 'RS XAD',
      'imageUrl': 'https://via.placeholder.com/80',
      'productName': 'Produk 1',
      'batchNomer': '2B813H9001',
      'pabrik': 'MARIN',
      'totalPrice': 'Rp 10.000.000',
    },
    {
      'nameCustomer': 'RS XAD',
      'imageUrl': 'https://via.placeholder.com/80',
      'productName': 'Produk 2',
      'batchNomer': '2B813H9001',
      'pabrik': 'PIM',
      'totalPrice': 'Rp 10.000.000',
    },
    {
      'nameCustomer': 'RS XAD',
      'imageUrl': 'https://via.placeholder.com/80',
      'productName': 'Produk 3',
      'batchNomer': '2B813H9001',
      'pabrik': 'Otsuka',
      'totalPrice': 'Rp 1.400.000',
    },
    {
      'nameCustomer': 'RS XAD',
      'imageUrl': 'https://via.placeholder.com/80',
      'productName': 'Produk 3',
      'batchNomer': '2B813H9001',
      'pabrik': 'Otsuka',
      'totalPrice': 'Rp 1.400.000',
    },
    {
      'nameCustomer': 'RS XAD',
      'imageUrl': 'https://via.placeholder.com/80',
      'productName': 'Produk 3',
      'batchNomer': '2B813H9001',
      'pabrik': 'Otsuka',
      'totalPrice': 'Rp 1.400.000',
    },
    {
      'nameCustomer': 'RS XAD',
      'imageUrl': 'https://via.placeholder.com/80',
      'productName': 'Produk 3',
      'batchNomer': '2B813H9001',
      'pabrik': 'Otsuka',
      'totalPrice': 'Rp 1.400.000',
    },
  ];

  final bool isAll;
  OrderList({super.key, this.isAll = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderCard(
          nameCustomer: orders[index]['nameCustomer']!,
          imageUrl: orders[index]['imageUrl']!,
          productName: orders[index]['productName']!,
          namePabrik: orders[index]['pabrik']!,
          batchNomer: orders[index]['batchNomer']!,
          totalPrice: orders[index]['totalPrice']!,
        );
      },
    );
  }
}
