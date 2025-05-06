import 'package:flutter/material.dart';
import 'package:coffeeshop_app/models/coffeecard.dart';
import 'package:coffeeshop_app/state/favourite_state.dart';
import 'package:coffeeshop_app/theme/app_theme.dart';
import 'package:iconly/iconly.dart';
import 'package:coffeeshop_app/screens/productdetailscreen.dart';
import 'package:coffeeshop_app/screens/homescreen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final favoriteState = FavoriteState();

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(IconlyLight.arrow_left),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        title: Text(
          'Favorites',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : AppColors.textDark,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : AppColors.textDark,
        ),
      ),
      body: ListenableBuilder(
        listenable: favoriteState,
        builder: (context, _) {
          final favorites = favoriteState.favoriteItems
              .toList(); // Convert to list for indexing

          if (favorites.isEmpty) {
            return _buildEmptyState(theme, isDarkMode);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites[index];
              return _FavoriteItem(
                product: product,
                isFavorite: true, // Always true in favorites screen
                onPressed: () =>
                    _toggleFavorite(context, product, favoriteState),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme, bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconlyLight.heart,
            size: 64,
            color: isDarkMode ? Colors.grey[400] : theme.disabledColor,
          ),
          const SizedBox(height: 16),
          Text(
            'No favorites yet',
            style: theme.textTheme.titleMedium?.copyWith(
              color: isDarkMode ? Colors.grey[400] : theme.disabledColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the heart icon on products to add favorites',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDarkMode ? Colors.grey[400] : AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleFavorite(
      BuildContext context, CoffeeModel product, FavoriteState state) {
    state.toggleFavorite(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed ${product.title} from favorites'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

class _FavoriteItem extends StatelessWidget {
  final CoffeeModel product;
  final bool isFavorite;
  final VoidCallback onPressed;

  const _FavoriteItem({
    required this.product,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isDarkMode ? AppColors.darkCard : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToDetail(context),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  product.imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(IconlyLight.image),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.white : AppColors.textDark,
                      ),
                    ),
                    if (product.subtitle.isNotEmpty)
                      Text(
                        product.subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color:
                              isDarkMode ? Colors.grey[400] : theme.hintColor,
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? IconlyBold.heart : IconlyLight.heart,
                  color: isFavorite ? Colors.red : theme.colorScheme.primary,
                ),
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }
}
