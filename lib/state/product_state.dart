import 'package:coffeeshop_app/models/coffeecard.dart';

class ProductDetailState {
  static CoffeeModel? selectedCoffee;

  static void setCoffee(CoffeeModel coffee) {
    selectedCoffee = coffee;
  }

  static CoffeeModel? getCoffee() {
    return selectedCoffee;
  }
}
