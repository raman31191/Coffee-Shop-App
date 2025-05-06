import 'package:coffeeshop_app/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:coffeeshop_app/models/coffeecard.dart';
import 'package:coffeeshop_app/theme/app_theme.dart';
import 'package:iconly/iconly.dart';
import 'package:coffeeshop_app/state/cart_state.dart';
import 'package:coffeeshop_app/state/favourite_state.dart';

class ProductDetailScreen extends StatefulWidget {
  final CoffeeModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? selectedSize;
  int quantity = 1;
  bool isFavorite = false; // Track favorite state
  void _favoriteListener() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    selectedSize =
        widget.product.sizes.isNotEmpty ? widget.product.sizes[0] : null;
    FavoriteState().addListener(_favoriteListener);
  }

  @override
  void dispose() {
    // 👇 Add this to clean up listener
    FavoriteState().removeListener(_favoriteListener);
    super.dispose();
  }

  void addToCart() {
    final cartState = CartState();
    for (int i = 0; i < quantity; i++) {
      cartState.addToCart(widget.product);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${widget.product.title} added to cart (x$quantity)"),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            );
          },
        ),
      ),
    );
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(isFavorite ? "Added to favorites" : "Removed from favorites"),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final product = widget.product;
    // final favoriteState = FavoriteState(); // Get favorite state instance
    //final isFavorite = favoriteState.isFavorite(widget.product);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(IconlyLight.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              FavoriteState().isFavorite(product)
                  ? IconlyBold.heart
                  : IconlyLight.heart,
              color: FavoriteState().isFavorite(product) ? Colors.red : null,
            ),
            onPressed: () {
              FavoriteState().toggleFavorite(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    FavoriteState().isFavorite(product)
                        ? 'Added to favorites'
                        : 'Removed from favorites',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'product-${product.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  product.imagePath,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Product Title and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : AppColors.textDark,
                  ),
                ),
                Text(
                  '\$${product.price}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Temperature and Rating
            Row(
              children: [
                Chip(
                  label: Text(
                    product.subtitle,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : AppColors.textDark,
                    ),
                  ),
                  backgroundColor: isDarkMode
                      ? AppColors.darkCard
                      : theme.colorScheme.secondary,
                ),
                const SizedBox(width: 12),
                const Icon(IconlyBold.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  product.rating,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : AppColors.textDark,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '(${product.ratingCount})',
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : theme.hintColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Text(
              "Description",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                product.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDarkMode ? Colors.grey[300] : AppColors.textDark,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              "Size",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: product.sizes.map((size) {
                final isSelected = size == selectedSize;
                return ChoiceChip(
                  label: Text(
                    size,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : (isDarkMode ? Colors.white : AppColors.textDark),
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) => setState(() => selectedSize = size),
                  selectedColor: theme.colorScheme.primary,
                  backgroundColor:
                      isDarkMode ? AppColors.darkCard : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: isDarkMode
                          ? Colors.grey[600]!
                          : AppColors.borderColor,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Quantity Stepper
            Text(
              "Quantity",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkCard : Colors.white,
                border: Border.all(
                  color: isDarkMode ? Colors.grey[600]! : AppColors.borderColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      IconlyLight.delete,
                      color: isDarkMode ? Colors.white : AppColors.textDark,
                    ),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },
                  ),
                  Text(
                    '$quantity',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: isDarkMode ? Colors.white : AppColors.textDark,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      IconlyLight.plus,
                      color: isDarkMode ? Colors.white : AppColors.textDark,
                    ),
                    onPressed: () {
                      setState(() => quantity++);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Only the Add to Cart Button remains
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: addToCart,
                child: const Text("Add to Cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
