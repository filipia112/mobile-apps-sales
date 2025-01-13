import 'package:apps_sales/data/model/order_detail_model.dart';
import 'package:flutter/material.dart';
import '../../utils/shared_preferences.dart';
import '../remote/api_service.dart';

class OrderDetailProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> addOrderDetail(List<OrderDetail> orderDetails) async {
    _isLoading = true;
    _errorMessage = 'Gagal menambahkan detail pesanan';
    notifyListeners();

    try {
      final token = await SharedPrefHelper.getToken();
      List<Map<String, dynamic>> updateOrderDetails = [];

      for (var orderDetail in orderDetails) {
        final updateOrderDetail = {
          'IdPesananPelanggan': orderDetail.idPesananPelanggan,
          'IdMenuProduk': orderDetail.idMenuProduk,
          'jumlahUnit': int.parse(orderDetail.jumlahUnit),
          'hargaPerUnit': int.parse(orderDetail.hargaPerunit),
          'totalHarga': int.parse(orderDetail.totalHarga),
        };
        updateOrderDetails.add(updateOrderDetail);
      }

      await ApiService().addOrderDetail(token!, updateOrderDetails);
    } catch (error) {
      _errorMessage = 'Gagal menambahkan detail order';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}