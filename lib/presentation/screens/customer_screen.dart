import 'package:apps_sales/presentation/widgets/widget_card_customer.dart';
import 'package:flutter/material.dart';

import '../../common/app_string.dart';
import '../../common/constants.dart';
class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        children: [
          _buildContent(context),
        ],
      ),
    );
  }
  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        Container(
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
                      AppString.itemNameMenu2,
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
        Expanded(
          child: CustomerList(),
        ),
      ],
    );
  }
}
