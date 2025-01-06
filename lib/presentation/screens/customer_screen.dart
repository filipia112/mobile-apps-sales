import 'package:apps_sales/presentation/widgets/widget_card_customer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/constants.dart';
import '../../data/provider/customer_provider.dart';
import '../widgets/widget_loading.dart';
class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<CustomerProvider>(context, listen: false).fetchCustomers();
    });
  }
  Future<void> _refreshData() async {
    await Provider.of<CustomerProvider>(context, listen: false).fetchCustomers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        children: [
          Consumer<CustomerProvider>(builder: (context, customerProvider, child) {
            if (customerProvider.isLoading) {
              return const LoadingWidget();
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
            } else if (customerProvider.customers == null) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Data Tidak Ditemukan',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView(
                children: [
                  const SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (customerProvider.customers != null) ...[
                          const CustomerList(),
                        ] else
                          const Center(
                            child: Text(
                              'Data Tidak Ditemukan',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              color: kPrimaryBlue,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Customer List',
                          style: kHeading5.copyWith(
                            fontSize: 20,
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
