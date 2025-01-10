import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/app_string.dart';
import '../../../common/constants.dart';
import '../../../data/provider/menu_product_provider.dart';
import '../../widgets/widget_card_menu.dart';
import '../../widgets/widget_card_sales.dart';
import '../../widgets/widget_loading.dart';
import '../../widgets/widgets_search.dart';
import '../all_menu_product.dart';
import '../cart_screen.dart';
import '../fliter_screen.dart';
import '../order_screen.dart';
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: kOffWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 310,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: kPrimaryBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                            child: SearchFieldHome(controller: searchController),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return const FilterScreen();
                                },
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(0.0, 1.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(position: offsetAnimation, child: child);
                                },
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.filter_alt_outlined,
                            color: kWhite,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return const CartScreen();
                                },
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(0.0, 1.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(position: offsetAnimation, child: child);
                                },
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.shopping_cart,
                            color: kWhite,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  top: 150,
                  left: 10,
                  right: 10,
                  child: SalesCard(),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Text(
              AppString.menuProduct,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Consumer<MenuProductProvider>(
              builder: (context, menuProductProvider, child) {
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
                          child: Text('Coba Lagi',
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
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    await Provider.of<MenuProductProvider>(context, listen: false)
                        .fetchMenuProducts();
                  },
                  child: ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProductList(isAll: false),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (menuProductProvider.errorMessage == null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => const AllMenuScreen(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      const begin = Offset(0, 1);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;
                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                      var offsetAnimation = animation.drive(tween);
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                AppString.detailListProduct,
                                style: TextStyle(fontSize: 16, color: kPrimaryBlue),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
