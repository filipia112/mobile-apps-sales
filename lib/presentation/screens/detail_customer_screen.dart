
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/constants.dart';
import '../../data/model/customer_model.dart';

class CustomerDetailScreen extends StatelessWidget {
  final CustomerModel customer;
  const CustomerDetailScreen({super.key, required this.customer});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(title: const Text('Detail Customer'),
        backgroundColor: kWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              customer.nmPelanggan,
              style: kHeading6,
            ),
            Text(
              customer.noSIPA,
              style: kHeading6,
            ),
            Text(
              customer.nmAPJ,
              style: kHeading6,
            ),
            Text(
              customer.berlakuIzinSarana != null
                  ? "Berlaku Izin Sarana: ${DateFormat('yyyy/MM/dd').format(customer.berlakuIzinSarana!)}"
                  : "Berlaku Izin Sarana: Tidak tersedia",
              style: kHeading6,
            ),
            SizedBox(
              width: 90,
              height: 36,
              child: Container(
                decoration: BoxDecoration(
                  color: customer.isVerified ? Colors.lightGreen : Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: customer.isVerified ? Colors.green : Colors.grey,
                      width: 2
                  ),
                ),
                child: Center(
                  child: Text(
                      customer.isVerified ? 'Valid' : 'Belum Valid',
                      style: kHeading6.copyWith(color: kWhite, fontSize: 14)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
