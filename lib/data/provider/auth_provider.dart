import '../../utils/shared_preferences.dart';
import '../model/auth_model.dart';
import '../remote/api_service.dart';
import 'package:flutter/material.dart';
class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userId;
  String? _nmUser;
  String? _username;
  String? _roleUser;
  DateTime? _updatedAt;
  String? _errorMessage;
  bool _isLoading = false;

  String? get token => _token;
  String? get userId => _userId;
  String? get nmUser => _nmUser;
  String? get username => _username;
  String? get roleUser => _roleUser;
  DateTime? get updatedAt => _updatedAt;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  set errorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  AuthProvider() {
    WidgetsBinding.instance.addPostFrameCallback((_) => checkAuthStatus());
  }

  Future<void> checkAuthStatus() async {
    _token = await SharedPrefHelper.getToken();
    _userId = await SharedPrefHelper.getUserId();

    if (_token != null && _userId != null) {
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
    }
    notifyListeners();
  }

  Future<bool> login(AuthModel authModel) async {
    _errorMessage = null;
    try {
      _isLoading = true;
      notifyListeners();
      final apiService = ApiService();
      final response = await apiService.login(authModel);

      _token = response.token;
      _userId = response.id;

      await SharedPrefHelper.saveToken(_token!);
      await SharedPrefHelper.saveUserId(_userId!);
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      errorMessage = "Gagal memuat data";
      return false;
    }
  }

  Future<void> logout() async {
    _errorMessage = null;
    _isAuthenticated = false;
    _token = null;
    _userId = null;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    try {
      final token = await SharedPrefHelper.getToken();

      if (token == null) {
        _isLoading = false;
        errorMessage = "Token tidak ditemukan";
        return;
      }

      final apiService = ApiService();
      await apiService.logout(token);
      await SharedPrefHelper.clearToken();
      await SharedPrefHelper.clearUserId();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      errorMessage = "Gagal memuat data";
    }
  }

  Future<void> loadUserData() async {
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    final token = await SharedPrefHelper.getToken();
    final userId = await SharedPrefHelper.getUserId();
    if (token != null && userId != null) {
      try {
        final apiService = ApiService();
        final userModel = await apiService.getUser(token, userId);
        _nmUser = userModel.nmUser;
        _username = userModel.username;
        _roleUser = userModel.roleUser;
        _updatedAt = userModel.updatedAt;

        _isLoading = false;
        notifyListeners();
      } catch (e) {
        _isLoading = false;
        errorMessage = "Gagal memuat data";
      }
    } else {
      _isLoading = false;
      errorMessage = "Token atau UserId tidak ditemukan. Data tidak ditemukan.";
    }
  }
}
