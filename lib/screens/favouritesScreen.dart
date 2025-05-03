import 'package:flutter/material.dart';
import 'package:coffeeshop_app/theme/app_theme.dart'; // adjust this import based on your folder structure

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
        child: Column(
          children: [
            // Example list of favorite items
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Replace with your actual favourites count
                itemBuilder: (context, index) {
                  return Card(
                    color: isDarkMode ? AppColors.darkCard : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: AppColors.borderColor,
                        width: 1,
                      ),
                    ),
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/coffee_${index + 1}.png', // replace with real asset path
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        'Coffee Name ${index + 1}',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'Category • \$${(4.0 + index).toStringAsFixed(2)}',
                        style: theme.textTheme.bodyMedium,
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          // Handle unfavourite logic
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
