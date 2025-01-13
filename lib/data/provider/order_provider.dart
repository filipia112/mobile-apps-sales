import 'package:apps_sales/data/remote/api_response.dart';
import 'package:apps_sales/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../model/add_order_model.dart';
import '../remote/api_service.dart';
class OrderProvider with ChangeNotifier {
  final ApiService apiService = ApiService();
  ApiResponseOrder? _orders;

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  ApiResponseOrder? get orders => _orders;

  Future<String?> addOrder(Order order) async {
    _isLoading = true;
    _errorMessage = 'Gagal menambahkan pesanan';
    notifyListeners();
    try {
      final userId = await SharedPrefHelper.getUserId();
      final token = await SharedPrefHelper.getToken();
      if (userId == null || token == null) {
        throw Exception("Token atau User ID tidak ditemukan");
      }

      final updateOrder = Order(
        idUser: userId,
        idPelanggan: order.idPelanggan,
        noPesanan: order.noPesanan,
        keterangan: order.keterangan,
      );

      final orderId = await apiService.addOrder(token, updateOrder);
      return orderId;
    } catch (error) {
      _errorMessage = 'Gagal menambahkan pesanan';
      notifyListeners();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchOrders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {

      final token = await SharedPrefHelper.getToken();
      final userId = await SharedPrefHelper.getUserId();

      if (token == null || token.isEmpty) {
        throw Exception("Token tidak ditemukan atau kosong");
      }

      if (userId == null || userId.isEmpty) {
        throw Exception("User ID tidak ditemukan atau kosong");
      }
      await Future.delayed(const Duration(seconds: 2));
      final response = await ApiService().fetchOrders(token);
      final filteredOrders = response.data
          .where((order) => order.idUser == userId)
          .toList();

      _orders = ApiResponseOrder(data: filteredOrders);
        } catch (error) {
      _errorMessage = "Gagal memuat data";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void retryFetchOrder() {
    fetchOrders();
  }
}
