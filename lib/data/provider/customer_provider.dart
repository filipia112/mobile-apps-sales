import 'package:apps_sales/data/remote/api_response.dart';
import 'package:flutter/cupertino.dart';
import '../../utils/shared_preferences.dart';
import '../remote/api_service.dart';

class CustomerProvider with ChangeNotifier {
  final ApiService apiService = ApiService();
  ApiResponseCustomer? _customers;
  bool _isLoading = false;
  String? _errorMessage;
  ApiResponseCustomer? get customers => _customers;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  set errorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
  Future<void> fetchCustomers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final token = await SharedPrefHelper.getToken();
      final userId = await SharedPrefHelper.getUserId();
      if (token == null) {
        throw Exception("Token tidak ditemukan");
      }
      await Future.delayed(const Duration(seconds: 2));
      final response = await apiService.fetchCustomer(token);
      final filteredCustomers = response.data.where((customer) => customer.idUser == userId).toList();
      _customers = ApiResponseCustomer(data: filteredCustomers);
    } catch (error) {
      errorMessage = "Gagal memuat data: $error";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void retryFetchCustomer() {
    fetchCustomers();
  }
}
