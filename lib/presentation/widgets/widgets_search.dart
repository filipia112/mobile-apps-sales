import 'package:apps_sales/common/app_string.dart';
import 'package:flutter/material.dart';
import '../../common/constants.dart';
import '../screens/all_menu_product.dart';
class SearchField extends StatelessWidget {
  final TextEditingController controller;

  const SearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: AppString.hintTextSearch,
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
class SearchFieldHome extends StatelessWidget {
  final TextEditingController controller;

  const SearchFieldHome({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const AllMenuScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              const curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var fadeAnimation = animation.drive(tween);
              return FadeTransition(opacity: fadeAnimation, child: child);
            },
          ),
        );
      }
    });

    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: AppString.hintTextSearch,
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
