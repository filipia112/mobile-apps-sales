import 'package:apps_sales/presentation/screens/account_screen.dart';
import 'package:apps_sales/presentation/screens/customer_screen.dart';
import 'package:apps_sales/presentation/screens/order_screen.dart';
import 'package:apps_sales/presentation/screens/stock_transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/app_string.dart';
import '../../../common/constants.dart';
import '../../../data/provider/auth_provider.dart';
import '../../../data/provider/menu_product_provider.dart';
import '../login_screen.dart';
import 'home_content.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const CustomerScreen(),
    const OrderScreen(),
    const AccountScreen()
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.checkAuthStatus();
      if (authProvider.isAuthenticated) {
        Provider.of<MenuProductProvider>(context, listen: false).fetchMenuProducts();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    const double navBarHeight = 70;
    return Scaffold(
      body: _pages[_currentIndex],
      backgroundColor: kWhite,
      bottomNavigationBar: SizedBox(
        height: navBarHeight,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          iconSize: 24,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: _currentIndex == 0
                  ? _buildActiveItem(Icons.home, AppString.itemNameMenu1, navBarHeight)
                  : const Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 1
                  ? _buildActiveItem(Icons.people_outline_rounded, AppString.itemNameMenu2, navBarHeight)
                  : const Icon(Icons.people_outline_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 2
                  ? _buildActiveItem(Icons.paste, AppString.itemNameMenu3, navBarHeight)
                  : const Icon(Icons.paste),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 3
                  ? _buildActiveItem(Icons.account_circle_rounded, AppString.itemNameMenu4, navBarHeight)
                  : const Icon(Icons.account_circle_rounded),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveItem(IconData icon, String label, double height) {
    return Container(
      height: height * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: kPrimaryBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 12 ),
          ),
        ],
      ),
    );
  }
}
