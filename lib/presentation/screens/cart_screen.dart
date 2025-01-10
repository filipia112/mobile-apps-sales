import 'package:apps_sales/common/constants.dart';
import 'package:apps_sales/presentation/widgets/widget_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/provider/cart_provider.dart';
import '../widgets/widget_card_cart.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<CartProvider>(context, listen: false).loadCarts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kPrimaryBlue,
        title: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return Text(
              'Keranjang Belanja (${cartProvider.totalItemCount})',
              style: kHeading5.copyWith(
                color: kWhite,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        iconTheme: const IconThemeData(
          color: kWhite,
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return IconButton(
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await cartProvider.clearCart();
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.isLoading) {
            return const LoadingWidget();
          }
          if (cartProvider.errorMessage.isNotEmpty) {
            return Center(
              child: Text(cartProvider.errorMessage),
            );
          }
          return cartProvider.cartItems.isNotEmpty
              ? ListView.builder(
            padding: const EdgeInsets.all(4.0),
            itemCount: cartProvider.cartItems.length,
            itemBuilder: (context, index) {
              final cart = cartProvider.cartItems[index];
              return CartCard(
                cart: cart,
                onRemove: (idCart) async {
                  await cartProvider.removeCart(idCart);
                },
              );
            },
          )
              : const Center(
            child: Text(
              'Keranjang Belanja Kosong.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}
