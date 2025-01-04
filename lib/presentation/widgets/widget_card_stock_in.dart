import 'package:flutter/material.dart';

import '../../common/constants.dart';
class StockInCard extends StatelessWidget {
  final String batchNomer;
  final String namePabrik;
  final String nameSupplier;
  final String totalStock;
  final String nameProduct;

  const StockInCard({
    Key? key,
    required this.batchNomer,
    required this.namePabrik,
    required this.nameSupplier,
    required this.totalStock,
    required this.nameProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: kOffWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '$namePabrik ( $nameSupplier )',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: kBodyText.copyWith(
                            color: kLightGrey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '+ $totalStock',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: kBodyText.copyWith(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          batchNomer,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kHeading6.copyWith(
                            fontSize: 14,
                            color: kPrimaryBlue,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          nameProduct,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kHeading6.copyWith(
                            fontSize: 16,
                            color: kPrimaryBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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

class StockInList extends StatelessWidget {
  final List<Map<String, String>> StockIns = [
    {
      'batchNomer': 'B1820021',
      'nmPabrik': 'PIM',
      'nmSupplier': 'PT ABC 220',
      'jumlahStok': '200',
      'nmProduk': 'Produk ABX',
    },
    {
      'batchNomer': 'XCP1221',
      'nmPabrik': 'Otsuka',
      'nmSupplier': 'PT CCA 220',
      'jumlahStok': '250',
      'nmProduk': 'Produk ABX',
    },
    {
      'batchNomer': 'B9430021',
      'nmPabrik': 'PIM',
      'nmSupplier': 'PT ABC 220',
      'jumlahStok': '30',
      'nmProduk': 'Produk ABX',
    },
    {
      'batchNomer': 'PA099430021',
      'nmPabrik': 'MARIN',
      'nmSupplier': 'PT ABC 220',
      'jumlahStok': '10',
      'nmProduk': 'Produk ABX',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: StockIns.length,
      itemBuilder: (context, index) {
        return StockInCard(
         batchNomer: StockIns[index]['batchNomer']!,
          namePabrik: StockIns[index]['nmPabrik']!,
          nameSupplier: StockIns[index]['nmSupplier']!,
          totalStock: StockIns[index]['jumlahStok']!,
          nameProduct: StockIns[index]['nmProduk']!,
        );
      },
    );
  }
}
