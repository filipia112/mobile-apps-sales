import 'package:flutter/material.dart';
import '../../utils/shared_preferences.dart';
import '../remote/api_response.dart';
import '../model/menu_product_model.dart';
import '../remote/api_service.dart';
class MenuProductProvider with ChangeNotifier {
  final ApiService apiService = ApiService();

  ApiResponseMenuProduct? _menuProducts;
  bool _isLoading = false;
  String? _errorMessage;
  List<MenuProductModel> _filteredProducts = [];

  ApiResponseMenuProduct? get menuProducts => _menuProducts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<MenuProductModel> get filteredProducts => _filteredProducts;

  set errorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> fetchMenuProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final token = await SharedPrefHelper.getToken();
      if (token == null) {
        throw Exception("Token tidak ditemukan");
      }

      await Future.delayed(const Duration(seconds: 2));
      final response = await apiService.fetchMenuProduct(token);
      _menuProducts = response;
      _filteredProducts = response.data;
    } catch (error) {
      errorMessage = "Gagal memuat data";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchProducts(String query) async {
    if (query.isEmpty) {
      _filteredProducts = _menuProducts?.data ?? [];
    } else {
      await Future.delayed(const Duration(seconds: 2));
      _filteredProducts = _menuProducts?.data
          .where((product) =>
      product.nmProduk.toLowerCase().contains(query.toLowerCase()) ||
          product.kodePabrik.toLowerCase().contains(query.toLowerCase()))
          .toList() ?? [];
    }
    notifyListeners();
  }

  void retryFetchMenuProducts() {
    fetchMenuProducts();
  }
}
