import 'dart:convert';
import 'package:apps_sales/data/model/auth_model.dart';
import 'package:apps_sales/data/model/auth_response_model.dart';
import 'package:apps_sales/data/model/user_model.dart';
import 'package:http/http.dart' as http;

import '../model/api_response.dart';
class ApiService {
  final String baseUrl;

  ApiService({this.baseUrl = 'http://103.127.99.159:4000/v1'});

  Future<T> _handleResponse<T>(http.Response response, T Function(Map<String, dynamic>) fromJson) async {
    if (response.statusCode == 200) {
      return fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<AuthResponseModel> login(AuthModel authModel) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(authModel.toJson()),
    );
    return _handleResponse(response, (data) => AuthResponseModel.fromJson(data));
  }
  Future<void> logout(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to logout');
    }
  }
  Future<UserModel> getUser(String token, String userId) async {
    final uri = Uri.parse('$baseUrl/auth/me')
        .replace(queryParameters: {'id': userId});

    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final apiResponse = ApiResponse.fromJson(jsonResponse);
      return apiResponse.data;
    } else {
      throw Exception('Failed to fetch user data: ${response.statusCode}');
    }

  }
}
