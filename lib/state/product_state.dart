import 'package:coffeeshop_app/models/coffeecard.dart';

class ProductDeailState {
  static CoffeeModel? selectedCoffee;

  static void setCoffee(CoffeeModel coffee) {
    selectedCoffee = coffee;
  }

  static CoffeeModel? getCoffee() {
    return selectedCoffee;
  }
}
