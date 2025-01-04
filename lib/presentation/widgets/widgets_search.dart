import 'package:flutter/material.dart';
import '../../common/constants.dart';
class SearchField extends StatelessWidget {
  final TextEditingController controller;

  const SearchField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Cari Menu Product disini...',
        hintStyle: kSubtitle.copyWith(color: Colors.black38),
        prefixIcon: const Icon(Icons.search, color: kPrimaryBlue),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kPrimaryBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kPrimaryBlue),
        ),
        fillColor: kWhite,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
      cursorColor: kPrimaryBlue,
    );
  }
}
