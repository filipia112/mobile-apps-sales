import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/constants.dart';
class SalesCard extends StatelessWidget {
  const SalesCard({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width * 1,
      height: height * 0.180,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: kWhite,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                _buildTotalAmount(),
                const SizedBox(height: 14),
                _buildStatsRow(),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTotalAmount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.monetization_on,
              color: Colors.green,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Rp.100.000.000',
              style: kHeading5.copyWith(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.today,
              color: kPrimaryBlue,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              DateFormat('yyyy-MM-dd').format(DateTime.now()),
              style: kHeading5.copyWith(
                color: Colors.blueGrey,
                fontSize: 14,
              ),
            ),
          ],
        )
      ],
    );
  }
  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildColumnWithIconAndValue(
          icon: Icons.list_alt,
          value: '100 Pesanan',
        )
      ],
    );
  }

  Widget _buildColumnWithIconAndValue({
    required IconData icon,
    required String value,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: kPrimaryBlue,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              value,
              style: kHeading5.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
