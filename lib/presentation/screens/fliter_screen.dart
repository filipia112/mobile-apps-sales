import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/app_string.dart';
import '../../common/constants.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        children: [
          _buildContent(context),
          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppString.searchMenubyFilter,
                          style: kHeading6.copyWith(color: Colors.black, fontSize: 24),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          TextField(
            decoration: InputDecoration(
              hintText: AppString.codeFactory,
              hintStyle: kSubtitle.copyWith(color: Colors.black38),
              prefixIcon: const Icon(Icons.factory, color: kPrimaryBlue),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: kLightGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: kPrimaryBlue),
              ),
              fillColor: kWhite.withOpacity(0.6),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            ),
            cursorColor: kPrimaryBlue,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: AppString.nameProduct,
              hintStyle: kSubtitle.copyWith(color: Colors.black38),
              prefixIcon: const Icon(Icons.table_rows, color: kPrimaryBlue),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: kLightGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: kPrimaryBlue),
              ),
              fillColor: kWhite.withOpacity(0.6),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            ),
            cursorColor: kPrimaryBlue,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Batch Nomer',
              hintStyle: kSubtitle.copyWith(color: Colors.black38),
              prefixIcon: const Icon(Icons.batch_prediction_sharp, color: kPrimaryBlue),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: kLightGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: kPrimaryBlue),
              ),
              fillColor: kWhite.withOpacity(0.6),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            ),
            cursorColor: kPrimaryBlue,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: AppString.category,
              hintStyle: kSubtitle.copyWith(color: Colors.black38),
              prefixIcon: const Icon(Icons.category, color: kPrimaryBlue),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: kLightGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: kPrimaryBlue),
              ),
              fillColor: kWhite.withOpacity(0.6),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            ),
            value: null,
            onChanged: (String? newValue) {
              // Handle change
            },
            items: <String>['Obat', 'Alkes']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            dropdownColor: kLightBlue,
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {

            },
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
              AppString.searchMenubyFilter,
              style: kHeading6.copyWith(fontSize: 18, color: kWhite),
            ),
          ),
        ],
      ),
    );
  }
}
