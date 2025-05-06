import 'package:flutter/foundation.dart';
import 'package:coffeeshop_app/models/coffeecard.dart';

class FavoriteState extends ChangeNotifier {
  static final FavoriteState _instance = FavoriteState._internal();
  factory FavoriteState() => _instance;
  FavoriteState._internal();

  final Set<CoffeeModel> _favoriteItems = {};

  Set<CoffeeModel> get favoriteItems => _favoriteItems;

  void toggleFavorite(CoffeeModel product) {
    if (_favoriteItems.contains(product)) {
      _favoriteItems.remove(product);
    } else {
      _favoriteItems.add(product);
    }
    notifyListeners();
  }

  bool isFavorite(CoffeeModel product) {
    return _favoriteItems.contains(product);
  }
}
