import 'package:apps_sales/data/model/menu_product_model.dart';
import 'package:apps_sales/data/model/user_model.dart';

import '../model/customer_model.dart';

class ApiResponseUser {
  final UserModel data;

  ApiResponseUser({required this.data});

  factory ApiResponseUser.fromJson(Map<String, dynamic> json) {
    return ApiResponseUser(
      data: UserModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }
}

class ApiResponseMenuProduct {
  final List<MenuProductModel> data;

  ApiResponseMenuProduct({required this.data});

  factory ApiResponseMenuProduct.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List?;
    List<MenuProductModel> menuProductList = [];
    if (list != null) {
      menuProductList = list.map((item) => MenuProductModel.fromJson(item)).toList();
    }

    return ApiResponseMenuProduct(
      data: menuProductList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
class ApiResponseCustomer {
  final List<CustomerModel> data;
  ApiResponseCustomer({required this.data});
  factory ApiResponseCustomer.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List?;
    List<CustomerModel> customerList = [];
    if (list != null) {
      customerList = list.map((item) => CustomerModel.fromJson(item)).toList();
    }
    return ApiResponseCustomer(
      data: customerList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
class ApiResponseOrder {
  final List<CustomerModel> data;
  ApiResponseOrder({required this.data});
  factory ApiResponseOrder.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List?;
    List<CustomerModel> customerList = [];
    if (list != null) {
      customerList = list.map((item) => CustomerModel.fromJson(item)).toList();
    }
    return ApiResponseOrder(
      data: customerList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
