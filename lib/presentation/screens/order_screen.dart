import 'package:apps_sales/common/constants.dart';
import 'package:apps_sales/presentation/widgets/widget_card_order.dart';
import 'package:flutter/material.dart';

import '../../common/app_string.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Text(
          AppString.order,
          style: kHeading6.copyWith(color: kPrimaryBlue, fontSize: 24),
        ),
        backgroundColor: kWhite,
        iconTheme: const IconThemeData(
          color: kPrimaryBlue,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: OrderList(),
          ),
        ],
      ),
    );
  }
}

