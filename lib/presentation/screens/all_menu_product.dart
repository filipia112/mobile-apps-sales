import 'package:apps_sales/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import '../../common/app_string.dart';
import '../../common/constants.dart';
import '../widgets/widget_card_menu.dart';
import '../widgets/widgets_search.dart';
class AllMenuScreen extends StatefulWidget {
  const AllMenuScreen({super.key});

  @override
  _AllMenuScreenState createState() => _AllMenuScreenState();
}
class _AllMenuScreenState extends State<AllMenuScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOffWhite,
      body: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductList(isAll: true),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 150,
              color: kOffWhite,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Center(
                        child: SearchField(controller: searchController),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                backgroundColor: kPrimaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                AppString.backHome,
                style: TextStyle(fontSize: 16, color: kWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

