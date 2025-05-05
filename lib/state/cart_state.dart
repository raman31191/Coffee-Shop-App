import 'package:flutter/foundation.dart';
import 'package:coffeeshop_app/models/coffeecard.dart';

class CartState extends ChangeNotifier {
  // Singleton pattern
  static final CartState _instance = CartState._internal();
  factory CartState() => _instance;
  CartState._internal();

  final Map<CoffeeModel, int> _cartItems = {};

  Map<CoffeeModel, int> get cartItems => Map.unmodifiable(_cartItems);

  void addToCart(CoffeeModel product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
    } else {
      _cartItems[product] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(CoffeeModel product) {
    if (_cartItems.containsKey(product)) {
      if (_cartItems[product]! > 1) {
        _cartItems[product] = _cartItems[product]! - 1;
      } else {
        _cartItems.remove(product);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
