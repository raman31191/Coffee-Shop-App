import 'package:flutter/material.dart';
import '../data/dummydata.dart';
import '../models/coffeecard.dart';

class CoffeeFilterState {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  List<String> categories = [
    'All Coffee',
    'Macchiato',
    'Latte',
    'Americano',
    'Cappuccino',
    'Espresso'
  ];

  List<CoffeeModel> get filteredList {
    final selectedCategory = _getCategory(selectedIndex.value);
    if (selectedCategory == 'All Coffee') return coffeeList;
    return coffeeList.where((c) => c.category == selectedCategory).toList();
  }

  void selectCategory(int index) {
    selectedIndex.value = index;
  }

  String _getCategory(int index) => categories[index];
}
