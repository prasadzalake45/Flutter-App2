import 'package:flutter/material.dart';
import 'package:login_form/cart_model.dart';
// Notifier that tell UI to update

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItem = [];

  List<CartItem> get cardItems => _cartItem;

  void addTocart(CartItem item) {
    _cartItem.add(item);
    notifyListeners();
  }
}
