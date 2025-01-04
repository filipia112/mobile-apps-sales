import 'package:apps_sales/presentation/widgets/widget_card_stock_in.dart';
import 'package:flutter/material.dart';

import '../../common/app_string.dart';
import '../../common/constants.dart';
import '../widgets/widget_card_stock_out.dart';

class StockTransactionScreen extends StatefulWidget {
  const StockTransactionScreen({super.key});

  @override
  _StockTransactionScreenState createState() => _StockTransactionScreenState();
}
class _StockTransactionScreenState extends State<StockTransactionScreen> {
  String? selectedOption; // Variabel untuk menyimpan pilihan dropdown

  @override
  Widget build(BuildContext context) {
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
                      AppString.stockTransaction,
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
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
            ),
            value: selectedOption,
            items: const [
              DropdownMenuItem(
                value: 'stockOut',
                child: Text(AppString.stockOut),
              ),
              DropdownMenuItem(
                value: 'stockIn',
                child: Text(AppString.stockIn),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedOption = value;
              });
            },
            hint: const Text("Select Transaction Type"),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: selectedOption == 'stockIn'
              ? StockInList()
              : selectedOption == 'stockOut'
              ? StockOutList()
              : Center(
            child: Text(
              "Please select a transaction type",
              style: kBodyText.copyWith(color: kLightGrey, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
 