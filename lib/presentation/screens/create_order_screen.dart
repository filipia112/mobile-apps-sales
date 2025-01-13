import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/constants.dart';
import '../../data/model/order_detail_model.dart';
import '../../data/model/add_order_model.dart';
import '../../data/provider/cart_provider.dart';
import '../../data/provider/order_detail_provider.dart';
import '../../data/provider/order_provider.dart';

class OrderScreen extends StatefulWidget {
  final String idPelanggan;
  final String idUser;
  final String noPesanan;

  const OrderScreen({
    required this.idPelanggan,
    required this.idUser,
    required this.noPesanan,
    super.key,
  });

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final TextEditingController _keteranganController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Text(
          'Buat Pesanan',
          style: kHeading5.copyWith(
              color: kPrimaryBlue,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: kWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _keteranganController,
              decoration: InputDecoration(
                hintText: 'Masukkan Keterangan Pesanan',
                hintStyle: kSubtitle.copyWith(color: Colors.black38),
                prefixIcon: const Icon(Icons.note_add_rounded, color: kPrimaryBlue),
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
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_keteranganController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Keterangan pesanan tidak boleh kosong.')),
                  );
                  return;
                }

                final order = Order(
                  idPelanggan: widget.idPelanggan,
                  idUser: widget.idUser,
                  noPesanan: widget.noPesanan,
                  keterangan: _keteranganController.text,
                );

                try {
                  final orderId = await Provider.of<OrderProvider>(context, listen: false).addOrder(order);
                  if (orderId != null) {
                    final selectedItems = Provider.of<CartProvider>(context, listen: false).cartItems
                        .where((item) => Provider.of<CartProvider>(context, listen: false).selectedItemIds.contains(item.idCart))
                        .toList();

                    List<OrderDetail> orderDetails = [];
                    for (var cartItem in selectedItems) {
                      final orderDetail = OrderDetail(
                        idPesananPelanggan: orderId,
                        idMenuProduk: cartItem.idMenuProduk,
                        jumlahUnit: cartItem.jumlahUnit.toString(),
                        hargaPerunit: cartItem.hargaPerUnit.toString(),
                        totalHarga: cartItem.totalHarga.toString(),
                      );

                      orderDetails.add(orderDetail);
                      await Provider.of<CartProvider>(context, listen: false).updateIsOrderDetail(cartItem.idCart, true);
                    }

                    await Provider.of<OrderDetailProvider>(context, listen: false).addOrderDetail(orderDetails);

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pesanan berhasil dibuat')),
                    );
                  } else {
                    throw Exception('Order ID tidak ditemukan.');
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gagal membuat pesanan')),
                  );
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
                'Konfirmasi Pesanan',
                style: kHeading6.copyWith(fontSize: 18, color: kWhite),
              ),
            )
          ],
        ),
      ),
    );
  }
}