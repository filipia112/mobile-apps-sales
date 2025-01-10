import 'dart:convert';
import 'package:apps_sales/data/model/auth_model.dart';
import 'package:apps_sales/data/model/auth_response_model.dart';
import 'package:apps_sales/data/model/order_model.dart';
import 'package:apps_sales/data/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'api_response.dart';

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
    final uri = Uri.parse('$baseUrl/auth/me').replace(queryParameters: {'id': userId});
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final apiResponseUser = ApiResponseUser.fromJson(jsonResponse);
      return apiResponseUser.data;
    } else {
      throw Exception('Failed to fetch user data');
    }
  }

  Future<ApiResponseMenuProduct> fetchMenuProduct(String token) async {
    final url = Uri.parse('$baseUrl/menu-product');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['success'] == true) {
        return ApiResponseMenuProduct.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Gagal mengambil data produk');
      }
    } else {
      throw Exception(
        'Gagal terhubung ke server',
      );
    }
  }
  Future<ApiResponseCustomer> fetchCustomer(String token) async {
    final url = Uri.parse('$baseUrl/customer/getAllDetailCustomer');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        return ApiResponseCustomer.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Gagal mengambil data customer');
      }
    } else {
      throw Exception('Gagal terhubung ke server');
    }
  }
  Future<ApiResponseOrder> fetchOrders(String token) async {
    final url = Uri.parse('$baseUrl/order');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        return ApiResponseOrder.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Gagal mengambil data Pesanan');
      }
    } else {
      throw Exception('Gagal terhubung ke server');
    }
  }

  Future<void> addOrder(String token, Order order) async {
    final response = await http.post(
      Uri.parse('$baseUrl/order'),
      headers: <String, String> {
       'Content-Type':'application/json',
       'Authorization': 'Bearer $token',
      },
      body: order.toJsonString()
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create order');
    }
  }

  Future<void> addOrderDetail(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/order/addDetailOrder'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed a create detail order');
    }
  }
  Future<ApiResponseMenuProduct> getMenuProducts({
    required String kodePabrik,
    required String nmPabrik,
    required String kategori,
    required String token
  }) async {
    final String url = '$baseUrl/v1/filter/menu-product?kodePabrik=$kodePabrik&nmPabrik=$nmPabrik&kategori=$kategori';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final apiResponse = ApiResponseMenuProduct.fromJson(responseBody);

        return apiResponse;
      } else {
        throw Exception('Failed to load menu products');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching menu products: $e');
    }
  }
}
