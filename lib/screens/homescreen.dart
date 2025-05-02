import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coffeeshop_app/data/dummydata.dart';
import 'package:coffeeshop_app/models/coffeecard.dart';
import 'package:coffeeshop_app/theme/app_theme.dart';
import 'package:iconly/iconly.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: BottomNavigationBar(
          currentIndex: 0,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          backgroundColor: isDarkMode ? AppColors.darkCard : Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.heart),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.buy),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.profile),
              label: '',
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location',
                          style: TextStyle(color: theme.hintColor)),
                      Row(
                        children: [
                          Text(
                            'New Delhi, India',
                            style: GoogleFonts.sora(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                          Icon(IconlyLight.arrow_down_2,
                              color: theme.textTheme.bodyLarge?.color),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: const Icon(IconlyLight.notification,
                        color: Colors.white),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.darkCard : AppColors.lightBeige,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    icon:
                        Icon(IconlyLight.search, color: theme.iconTheme.color),
                    hintText: 'Search coffee',
                    hintStyle: TextStyle(color: theme.hintColor),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                ),
              ),

              const SizedBox(height: 20),

              // Promo Banner
              Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/Cafe_latte.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Promo',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Buy one get\none FREE',
                          style: GoogleFonts.sora(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Category Filters
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryChip('All Coffee', true, theme),
                    _buildCategoryChip('Macchiato', false, theme),
                    _buildCategoryChip('Latte', false, theme),
                    _buildCategoryChip('Americano', false, theme),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Coffee Grid
              Expanded(
                child: GridView.builder(
                  itemCount: coffeeList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (ctx, index) {
                    final coffee = coffeeList[index];
                    return _buildCoffeeCard(coffee, theme);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool selected, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            selected ? AppColors.primaryColor : theme.colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildCoffeeCard(CoffeeModel coffee, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              coffee.imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          // Name
          Text(
            coffee.title,
            style: GoogleFonts.sora(
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          // Description
          Text(
            coffee.subtitle,
            style: TextStyle(
              color: theme.hintColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          // Price and Add
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${coffee.price}',
                style: GoogleFonts.sora(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: const Icon(IconlyBold.plus, color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
