import 'package:apps_sales/data/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/constants.dart';
import '../../data/provider/customer_provider.dart';
import '../screens/detail_customer_screen.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({super.key});
  @override
  Widget build(BuildContext context) {
    var customerProvider = Provider.of<CustomerProvider>(context);
    if (customerProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (customerProvider.errorMessage != null) {
      return Center(
        child: Text(customerProvider.errorMessage!),
      );
    }
    List<CustomerModel> displayedCustomers = customerProvider.customers?.data ?? [];
    if (displayedCustomers.isEmpty) {
      return const Center(
        child: Text('Tidak ada data pelanggan.'),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: displayedCustomers.length,
      itemBuilder: (context, index) {
        final customer = displayedCustomers[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: CustomerCard(
            nmPelanggan: customer.nmPelanggan,
            noPelanggan: customer.noPelanggan,
            alamatPelanggan: customer.alamatPelanggan,
            customer: customer,
            isVerified: customer.isVerified,
          ),
        );
      },
    );
  }
}


class CustomerCard extends StatelessWidget {
  final String nmPelanggan;
  final String noPelanggan;
  final String alamatPelanggan;
  final bool isVerified;
  final CustomerModel customer;

  const CustomerCard({
    super.key,
    required this.nmPelanggan,
    required this.noPelanggan,
    required this.alamatPelanggan,
    required this.customer,
    required this.isVerified
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => CustomerDetailScreen(customer: customer),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            ),
          );
        },
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            nmPelanggan,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: kBodyText.copyWith(color: kLightGrey),
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          height: 36,
                          child: Icon(
                            customer.isVerified ? Icons.check_circle : Icons.warning,
                            color: customer.isVerified ? Colors.green : Colors.red,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            alamatPelanggan,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: kHeading6.copyWith(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      noPelanggan,
                      style: kHeading6.copyWith(color: kPrimaryBlue, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
