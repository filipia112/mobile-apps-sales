import 'package:apps_sales/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/app_string.dart';
import '../../common/constants.dart';
import '../../data/provider/menu_product_provider.dart';
import '../widgets/widget_card_menu.dart';
import '../widgets/widget_loading.dart';
import '../widgets/widgets_search.dart';
class AllMenuScreen extends StatefulWidget {
  const AllMenuScreen({super.key});

  @override
  _AllMenuScreenState createState() => _AllMenuScreenState();
}
class _AllMenuScreenState extends State<AllMenuScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<MenuProductProvider>(context, listen: false).fetchMenuProducts();
    });
    searchController.addListener(() {
      Provider.of<MenuProductProvider>(context, listen: false)
          .searchProducts(searchController.text);
    });
  }
  Future<void> _refreshData() async {
    await Provider.of<MenuProductProvider>(context, listen: false).fetchMenuProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOffWhite,
      body: Stack(
        children: [
          Consumer<MenuProductProvider>(builder: (context, menuProductProvider, child) {
            if (menuProductProvider.isLoading) {
              return const LoadingWidget();
            }
            if (menuProductProvider.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(menuProductProvider.errorMessage!),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        menuProductProvider.retryFetchMenuProducts();
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
            } else if (menuProductProvider.filteredProducts.isEmpty) {
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
                  SizedBox(height: 100),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductList(isAll: true),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
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
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
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


