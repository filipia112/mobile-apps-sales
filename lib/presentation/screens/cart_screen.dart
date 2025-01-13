import 'package:apps_sales/common/constants.dart';
import 'package:apps_sales/presentation/widgets/widget_loading.dart';
import 'package:apps_sales/utils/format.dart';
import 'package:apps_sales/utils/random_no_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/customer_model.dart';
import '../../data/model/add_order_model.dart';
import '../../data/provider/cart_provider.dart';
import '../../data/provider/order_provider.dart';
import '../widgets/widget_card_cart.dart';
import '../widgets/widget_show_dialog.dart';
import 'create_order_screen.dart';
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
        backgroundColor: kWhite,
        title: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return Text(
              'Keranjang Belanja (${cartProvider.totalItemCount})',
              style: kHeading5.copyWith(
                color: kPrimaryBlue,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        iconTheme: const IconThemeData(
          color: kPrimaryBlue,
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return IconButton(
                icon: const Icon(
                  Icons.delete_forever,
                  color: kPrimaryBlue,
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
              ? Column(
            children: [
              Expanded(
                child: ListView.builder(
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total yang dipilih:'),
                        Consumer<CartProvider>(
                          builder: (context, cartProvider, child) {
                            return Text(
                              formatCurrency(cartProvider.totalSelectedItems.toString()),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryBlue,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (cartProvider.totalSelectedItems == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Silakan pilih item di keranjang terlebih dahulu.')),
                          );
                          return;
                        }

                        final selectedCustomer = await showDialog<CustomerModel>(
                          context: context,
                          builder: (context) => CustomerSelectionDialog(),
                        );
                        if (selectedCustomer != null) {
                          try {
                            String random = await RandomNoOrder.generateRandomStringFromDateAndUserId();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderScreen(
                                  idPelanggan: selectedCustomer.idPelanggan,
                                  idUser: '',
                                  noPesanan: random,
                                ),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Gagal menambah ke keranjang: $e')),
                            );
                          }
                        }
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
                        'Buat Pesanan',
                        style: kHeading6.copyWith(fontSize: 18, color: kWhite),
                      ),
                    )

                  ],
                ),
              )
            ],
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
