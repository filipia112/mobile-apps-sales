import 'package:flutter/cupertino.dart';
import '../database/db_helper.dart';
import '../model/cart_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Cart> _cartItems = [];
  String _errorMessage = '';
  bool _isLoading = false;

  Set<String> _selectedItemIds = {};

  List<Cart> get cartItems => _cartItems;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  Set<String> get selectedItemIds => _selectedItemIds;
  int get totalItemCount => _cartItems.length;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  int get totalSelectedItems {
    int total = 0;
    for (var cartItem in _cartItems) {
      if (_selectedItemIds.contains(cartItem.idCart)) {
        total += cartItem.totalHarga;
      }
    }
    return total;
  }

  void toggleItemSelection(String idCart) {
    if (_selectedItemIds.contains(idCart)) {
      _selectedItemIds.remove(idCart);
    } else {
      _selectedItemIds.add(idCart);
    }
    notifyListeners();
  }

  void _setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> loadCarts() async {
    _setLoading(true);
    try {
      _cartItems = await DBHelper.instance.getAllCarts();
      _setErrorMessage('');
    } catch (e) {
      _handleError('Failed to load carts');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addCart(Cart cart) async {
    _setLoading(true);
    try {
      await DBHelper.instance.insertCart(cart);
      _cartItems.add(cart);
      _setErrorMessage('');
    } catch (e) {
      _handleError('Failed to add cart');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateIsOrderDetail(String idCart, bool isOrderDetail) async {
    _setLoading(true);
    try {
      await DBHelper.instance.updateIsOrderDetail(idCart, isOrderDetail);
      _cartItems = await DBHelper.instance.getAllCarts();
      _setErrorMessage('');
    } catch (e) {
      _handleError('Failed to update order detail');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> removeCart(String idCart) async {
    _setLoading(true);
    try {
      await DBHelper.instance.removeCart(idCart);
      _cartItems.removeWhere((cart) => cart.idCart == idCart);
      _setErrorMessage('');
    } catch (e) {
      _handleError('Failed to remove cart');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> clearCart() async {
    _setLoading(true);
    try {
      await DBHelper.instance.clearCart();
      _cartItems.removeWhere((cart) => !cart.isOrderDetail);
      _setErrorMessage('');
    } catch (e) {
      _handleError('Failed to clear cart');
    } finally {
      _setLoading(false);
    }
  }

  void _handleError(String message) {
    _setErrorMessage(message);
  }
}

