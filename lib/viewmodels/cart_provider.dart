import 'package:easy_mart/modals/cart_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<CartModel> _cart = [];

  List<CartModel> get cartItems => _cart;

  void addToCart(CartModel item) {
    int index = _cart.indexWhere((e) => e.id == item.id);

    if (index != -1) {
      _cart[index].qty++;
    } else {
      _cart.add(item);
    }

    notifyListeners();
  }

  void removeItem(int id) {
    _cart.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    for (var item in _cart) {
      total += item.price * item.qty;
    }
    return total;
  }

  void increaseQty(int id) {
    int index = _cart.indexWhere((e) => e.id == id);
    if (index != -1) {
      _cart[index].qty++;
      notifyListeners();
    }
  }

  void decreaseQty(int id) {
    int index = _cart.indexWhere((e) => e.id == id);
    if (index != -1 && _cart[index].qty > 1) {
      _cart[index].qty--;
      notifyListeners();
    }
  }

  double get subtotal {
    double total = 0;

    for (var item in _cart) {
      total += item.price * item.qty;
    }

    return total;
  }

  double get tax => subtotal * 0.05;

  double get deliveryCharge => subtotal > 500 ? 0 : 40;

  double get discount => 0;

  double get total {
    return subtotal + tax + deliveryCharge - discount;
  }
}
