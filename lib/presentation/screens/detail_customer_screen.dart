
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
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.asset(
                'lib/assets/images/man.png',
                width: double.infinity,
                height: 150,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 150),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  customer.nmPelanggan,
                  style: kHeading6.copyWith(color: Colors.black87),
                ),
                const SizedBox(width: 12),
                Icon(
                  customer.isVerified ? Icons.check_circle : Icons.warning,
                  color: customer.isVerified ? Colors.green : Colors.red,
                  size: 24,
                ),
                Text(
                  customer.isVerified ? 'Valid' : 'Belum Valid',
                  style: kSubtitle.copyWith(color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No Pelanggan',
                      style: kSubtitle.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      customer.noPelanggan,
                      style: kBodyText.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Nomor HP',
                      style: kSubtitle.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      customer.noTelp,
                      style: kBodyText.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Alamat Pelanggan',
                      style: kSubtitle.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      customer.alamatPelanggan,
                      style: kBodyText.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Wilayah',
                      style: kSubtitle.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      customer.wilayah,
                      style: kBodyText.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No Izin Sarana',
                      style: kSubtitle.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      customer.noIzinSarana,
                      style: kBodyText.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Masa berlaku No Izin Sarana',
                      style: kSubtitle.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      customer.berlakuIzinSarana != null
                          ? "Berlaku Izin Sarana: ${DateFormat('yyyy/MM/dd').format(customer.berlakuIzinSarana!)}"
                          : "Berlaku Izin Sarana: Tidak tersedia",
                      style: kSubtitle.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No SIPA',
                      style: kSubtitle.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      customer.noSIPA,
                      style: kBodyText.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Nama APJ',
                      style: kSubtitle.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      customer.nmAPJ,
                      style: kBodyText.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Masa Berlaku SIPA',
                      style: kSubtitle.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      customer.berlakuSIPA != null
                          ? "Berlaku Izin Sarana: ${DateFormat('yyyy/MM/dd').format(customer.berlakuSIPA!)}"
                          : "Berlaku Izin Sarana: Tidak tersedia",
                      style: kSubtitle.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Terakhir diubah',
                            style: kSubtitle.copyWith(color: Colors.black54),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                customer.diubah != null
                                    ? DateFormat("dd/MM/yyyy").format(customer.diubah.toLocal())
                                    : "Tidak ada data",
                                style: kSubtitle.copyWith(color: Colors.black),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                customer.diubah != null
                                    ? DateFormat.jm().format(customer.diubah.toLocal())
                                    : "Tidak ada data",
                                style: kSubtitle.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
