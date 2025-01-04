import 'package:flutter/material.dart';

import '../../common/constants.dart';
class CustomerCard extends StatelessWidget {
  final String nameCustomer;
  final String addressCustomer;
  final String noCDOB;

  const CustomerCard({
    Key? key,
    required this.nameCustomer,
    required this.addressCustomer,
    required this.noCDOB,
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
                          nameCustomer,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: kBodyText.copyWith(color: kLightGrey),
                        ),
                      ),
                      SizedBox(
                        width: 90,
                        height: 36,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.lightGreen,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.green,
                              width: 2
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Verifikasi',
                                style: kHeading6.copyWith(color: kWhite, fontSize: 14)
                            ),
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
                          addressCustomer,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: kHeading6.copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    noCDOB,
                    style: kHeading6.copyWith(color: kPrimaryBlue, fontSize: 16),
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

class CustomerList extends StatelessWidget {
  final List<Map<String, String>> Customers = [
    {
      'nmPelanggan': 'RS ABC',
      'addressCustomer': 'Jalan Kenung No 29',
      'noCDOB': '12100310-130301931'
    },
    {
      'nmPelanggan': 'RS XYZ',
      'addressCustomer': 'Jalan Merdeka No 5',
      'noCDOB': '12100310-130301932'
    },
    {
      'nmPelanggan': 'RS DEF',
      'addressCustomer': 'Jalan Raya No 12',
      'noCDOB': '12100310-130301933'
    },
    {
      'nmPelanggan': 'RS GHI',
      'addressCustomer': 'Jalan Sudirman No 7',
      'noCDOB': '12100310-130301934'
    },
    {
      'nmPelanggan': 'RS GHI',
      'addressCustomer': 'Jalan Sudirman No 7',
      'noCDOB': '12100310-130301934'
    },
    {
      'nmPelanggan': 'RS GHI',
      'addressCustomer': 'Jalan Sudirman No 7',
      'noCDOB': '12100310-130301934'
    },
    {
      'nmPelanggan': 'RS GHI',
      'addressCustomer': 'Jalan Sudirman No 7',
      'noCDOB': '12100310-130301934'
    },
    {
      'nmPelanggan': 'RS GHI',
      'addressCustomer': 'Jalan Sudirman No 7',
      'noCDOB': '12100310-130301934'
    },
    {
      'nmPelanggan': 'RS GHI',
      'addressCustomer': 'Jalan Sudirman No 7',
      'noCDOB': '12100310-130301934'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Customers.length,
      itemBuilder: (context, index) {
        return CustomerCard(
          nameCustomer: Customers[index]['nmPelanggan']!,
          addressCustomer: Customers[index]['addressCustomer']!,
          noCDOB: Customers[index]['noCDOB']!,
        );
      },
    );
  }
}
