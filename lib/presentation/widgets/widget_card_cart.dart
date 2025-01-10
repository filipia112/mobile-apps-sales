import 'package:apps_sales/presentation/widgets/widget_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../data/model/cart_model.dart';
import '../../data/provider/cart_provider.dart';
import '../../utils/format.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    if (cartProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (cartProvider.errorMessage.isNotEmpty) {
      return Center(
        child: Text(cartProvider.errorMessage),
      );
    }

    List<Cart> cartItems = cartProvider.cartItems ?? [];

    if (cartItems.isEmpty) {
      return const Center(
        child: Text('Keranjang Belanja Kosong.'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final cartItem = cartItems[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: CartCard(
            cart: cartItem,
            onRemove: (idCart) async {
              try {
                await cartProvider.removeCart(idCart);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Item removed successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to remove item: $e')),
                );
              }
            },
          ),
        );
      },
    );
  }
}

class CartCard extends StatefulWidget {
  final Cart cart;
  final Future<void> Function(String idCart) onRemove;

  const CartCard({super.key, required this.cart, required this.onRemove});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  bool isLoading = false;

  Future<void> _removeItem() async {
    setState(() {
      isLoading = true;
    });
    try {
      await widget.onRemove(widget.cart.idCart);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove item: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Dismissible(
        key: Key(widget.cart.idCart),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          _removeItem();
        },
        background: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.circle_outlined, color: Colors.grey),
                        onPressed: _removeItem,
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.network(
                          widget.cart.gambarPath,
                          width: MediaQuery.of(context).size.width * 0.20,
                          height: MediaQuery.of(context).size.width * 0.20,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.broken_image, size: MediaQuery.of(context).size.width * 0.4),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.cart.nmProduk.split(" ").take(3).join(" "),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            widget.cart.nmProduk.split(" ").skip(3).join(" "),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            formatCurrency(widget.cart.totalHarga.toString()),
                            style: kSubtitle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryBlue,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black38,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: SizedBox(
                          width: 50,
                          height: 25,
                          child: Center(
                            child: Text(
                              widget.cart.jumlahUnit.toString(),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// isLoading
// ? const CircularProgressIndicator()
//     : IconButton(
// icon: const Icon(Icons.delete_forever),
// onPressed: _handleRemove,
// ),