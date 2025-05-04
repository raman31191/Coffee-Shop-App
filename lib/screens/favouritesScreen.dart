import 'package:flutter/material.dart';
import 'package:coffeeshop_app/theme/app_theme.dart'; // Adjust path if needed

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Sample favorite coffee list (you can replace this with real data)
    final List<String> favoriteItems = [
      'Cappuccino',
      'Latte Macchiato',
      'Espresso',
      'Caramel Cold Brew',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourites',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: favoriteItems.isEmpty
            ? Center(
                child: Text(
                  'No favourites yet.',
                  style: theme.textTheme.bodyLarge,
                ),
              )
            : ListView.separated(
                itemCount: favoriteItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.darkCard : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          favoriteItems[index],
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            // TODO: Handle removing from favourites
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
