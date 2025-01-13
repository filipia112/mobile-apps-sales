import 'package:apps_sales/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/app_string.dart';
import '../../data/provider/order_provider.dart';
import '../widgets/widget_card_order.dart';
import '../widgets/widget_loading.dart';
class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<OrderProvider>(context, listen: false).fetchOrders();
    });
  }

  Future<void> _refreshData() async {
    await Provider.of<OrderProvider>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Daftar Pesanan',
          style: kHeading5.copyWith(
              color: kPrimaryBlue,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: kWhite,
      ),
      body: Stack(
        children: [
          Consumer<OrderProvider>(builder: (context, orderProvider, child) {
            if (orderProvider.isLoading) {
              return const LoadingWidget();
            }

            if (orderProvider.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(orderProvider.errorMessage!),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        orderProvider.fetchOrders();
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
            } else if (orderProvider.orders?.data == null || orderProvider.orders!.data.isEmpty) {
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
                children: const [
                  SizedBox(height: 70),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OrderList(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
