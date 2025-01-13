import 'package:apps_sales/data/model/fetch_order_model.dart';
import 'package:apps_sales/presentation/widgets/widget_loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../common/constants.dart';
import '../../data/provider/order_provider.dart';
class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<OrderProvider>(context);

    if (orderProvider.isLoading) {
      return const Center(child: LoadingWidget());
    }

    if (orderProvider.errorMessage != null) {
      return Center(
        child: Text(orderProvider.errorMessage!),
      );
    }

    List<FetchOrder> displayedOrders = orderProvider.orders?.data.cast<FetchOrder>() ?? [];

    if (displayedOrders.isEmpty) {
      return const Center(
        child: Text('Tidak ada data pesanan.'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: displayedOrders.length,
      itemBuilder: (context, index) {
        final order = displayedOrders[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: OrderCard(order: order),
        );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final FetchOrder order;
  const OrderCard({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          // Implement action when card is tapped
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
                            order.nmPelanggan,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: kBodyText.copyWith(color: kLightGrey),
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          height: 36,
                          child: Icon(
                            order.isVerified ? Icons.check_circle : Icons.warning,
                            color: order.isVerified ? Colors.green : Colors.red,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.noPesanan,
                      style: kHeading6.copyWith(color: kPrimaryBlue, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.dibuat != null
                          ? DateFormat("dd/MM/yyyy").format(order.dibuat.toLocal())
                          : "Tidak ada data",
                      style: kSubtitle.copyWith(color: Colors.black),
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