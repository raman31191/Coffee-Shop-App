import 'package:flutter/material.dart';

class CoffeeModel {
  final String id; // Added from Product
  final String title;
  final String subtitle; // temperature (Ice/Hot)
  final String category;
  final String price;
  final String rating;
  final String imagePath;
  final List<String> sizes;
  final List<IconData> icons;
  final String description; // Added from Product
  final int ratingCount; // Added from Product
  final List<String> tags; // Added from Product

  CoffeeModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.price,
    required this.rating,
    required this.imagePath,
    required this.sizes,
    required this.icons,
    required this.description,
    required this.ratingCount,
    required this.tags,
  });

  // Helper method for price display
  String get formattedPrice => '\$$price';
}
