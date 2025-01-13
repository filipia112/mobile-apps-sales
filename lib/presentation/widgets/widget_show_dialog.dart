import 'package:apps_sales/common/constants.dart';
import 'package:apps_sales/presentation/widgets/widget_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/provider/customer_provider.dart';

class CustomerSelectionDialog extends StatefulWidget {
  const CustomerSelectionDialog({super.key});

  @override
  _CustomerSelectionDialogState createState() => _CustomerSelectionDialogState();
}
class _CustomerSelectionDialogState extends State<CustomerSelectionDialog> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<CustomerProvider>(context, listen: false).fetchCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pilih Pelanggan'),
      backgroundColor: kWhite,
      content: Consumer<CustomerProvider>(
        builder: (context, customerProvider, child) {
          if (customerProvider.isLoading) {
            return const Center(child: LoadingWidget());
          }
          if (customerProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(customerProvider.errorMessage!),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      customerProvider.retryFetchCustomer();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.5,
                        50,
                      ),
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.redAccent, width: 2),
                      ),
                    ),
                    child: Text(
                      'Coba Lagi',
                      style: kHeading6.copyWith(
                        fontSize: 14,
                        color: kWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          final customers = customerProvider.customers?.data;
          if (customers == null || customers.isEmpty) {
            return const Text('Tidak ada pelanggan yang tersedia.');
          }
          return SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          customer.nmPelanggan,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(customer.noPelanggan),
                  onTap: () {
                    Navigator.of(context).pop(customer);
                  },
                  trailing: Icon(
                    customer.isVerified ? Icons.check_circle : Icons.warning,
                    color: customer.isVerified ? Colors.green : Colors.red,
                    size: 24,
                  ),
                );
              },
            ),
          );
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(
              MediaQuery.of(context).size.width * 1,
              60,
            ),
            backgroundColor: kPrimaryBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: kPrimaryBlue, width: 2),
            ),
          ),
          child: Text(
            'Batal',
            style: kHeading6.copyWith(fontSize: 18, color: kWhite),
          ),
        ),
      ],
    );
  }
}
