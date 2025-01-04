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

  String? get token => _token;
  String? get userId => _userId;
  String? get nmUser => _nmUser;
  String? get username => _username;
  String? get roleUser => _roleUser;
  DateTime? get updatedAt => _updatedAt;


  bool get isAuthenticated => _token != null;

  Future<void> login(AuthModel authModel) async {
    try {
      final apiService = ApiService();
      final response = await apiService.login(authModel);

      _token = response.token;
      _userId = response.id;

      await SharedPrefHelper.saveToken(_token!);
      await SharedPrefHelper.saveUserId(_userId!);

      notifyListeners();
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }


  Future<void> logout() async {
    try {
      final token = await SharedPrefHelper.getToken();

      if (token == null) {
        throw Exception('Token not found');
      }

      final apiService = ApiService();
      await apiService.logout(token);

      _token = null;
      _userId = null;

      await SharedPrefHelper.clearToken();
      await SharedPrefHelper.clearUserId();

      notifyListeners();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }
  Future<void> loadUserData() async {
    final token = await SharedPrefHelper.getToken();
    final userId = await SharedPrefHelper.getUserId();

    if (token != null && userId != null) {
      try {
        final apiService = ApiService();
        final userModel = await apiService.getUser(token, userId);

        _token = token;
        _userId = userId;
        _nmUser = userModel.nmUser;
        _username = userModel.username;
        _roleUser = userModel.roleUser;
        _updatedAt = userModel.updatedAt;

        notifyListeners();
      } catch (e) {
        throw Exception('Failed to load user data: $e');
      }
    }
  }
}
