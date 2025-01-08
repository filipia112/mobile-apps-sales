import 'package:apps_sales/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../model/order_model.dart';
import '../remote/api_service.dart';

class OrderProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> addOrder(Order order) async {
    _isLoading = true;
    _errorMessage = 'Gagal menambahkan pesanan';
    notifyListeners();
    try {
      final userId =  await SharedPrefHelper.getUserId();
      final token =  await SharedPrefHelper.getToken();
      final updateOrder = Order(
        idUser: userId!,
        idPelanggan: order.idPelanggan,
        noPesanan: order.noPesanan,
        keterangan: order.keterangan
      );
      print("Id User  :  $userId");
      print("Token  :  $token");
      await ApiService().addOrder(token!, updateOrder);
    } catch (error) {
      print(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}