import 'package:coffeeshop_app/screens/cart.dart';
import 'package:coffeeshop_app/screens/favourites_screen.dart';
import 'package:coffeeshop_app/screens/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:coffeeshop_app/data/dummydata.dart';
import 'package:coffeeshop_app/models/coffeecard.dart';
import 'package:coffeeshop_app/theme/app_theme.dart';
import 'package:iconly/iconly.dart';
import 'package:coffeeshop_app/screens/productdetailscreen.dart';
import 'package:coffeeshop_app/state/cart_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void _onCheckoutSuccess() {
  // You can put your logic here for handling a successful checkout
  print("Checkout was successful!");
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<CoffeeModel> emptyCart = [];
  final List<Widget> _screens = [
    const HomeContent(),
    const FavouriteScreen(),
    CartScreen(onCheckoutSuccess: _onCheckoutSuccess),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: _screens[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: theme.hintColor,
          showUnselectedLabels: false,
          backgroundColor: isDarkMode ? AppColors.darkCard : Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: ''),
            BottomNavigationBarItem(icon: Icon(IconlyBold.heart), label: ''),
            BottomNavigationBarItem(icon: Icon(IconlyBold.buy), label: ''),
            BottomNavigationBarItem(icon: Icon(IconlyBold.profile), label: ''),
          ],
        ),
      ),
    );
  }
}

final List<String> categories = [
  'All Coffee',
  'Macchiato',
  'Latte',
  'Americano',
  'Cappuccino',
  'Espresso'
];

class CoffeeFilterState {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  List<CoffeeModel> get filteredList {
    if (selectedIndex.value == 0) {
      return coffeeProducts;
    } else {
      final selectedCategory = categories[selectedIndex.value];
      return coffeeProducts
          .where((coffee) => coffee.title
              .toLowerCase()
              .contains(selectedCategory.toLowerCase()))
          .toList();
    }
  }

  void selectCategory(int index) {
    selectedIndex.value = index;
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final CoffeeFilterState filterState = CoffeeFilterState();

  @override
  void dispose() {
    filterState.selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 200,
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
        SafeArea(
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
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(IconlyLight.arrow_down_2,
                                color: theme.iconTheme.color),
                          ],
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: theme.colorScheme.primary,
                      child:
                          Icon(IconlyLight.notification, color: Colors.white),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? AppColors.darkCard
                              : AppColors.lightBeige,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            icon: Icon(
                              IconlyLight.search,
                              color: theme.iconTheme.color,
                            ),
                            hintText: 'Search coffee',
                            hintStyle: TextStyle(color: theme.hintColor),
                            border: InputBorder.none,
                          ),
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: IconButton(
                        icon: Icon(
                          IconlyBold.filter,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Promo Banner
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/coffee_banner.png'),
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
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('Promo',
                                style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Buy one get\none FREE',
                            style: theme.textTheme.bodyLarge?.copyWith(
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

                // Category Selector
                SizedBox(
                  height: 36,
                  child: ValueListenableBuilder<int>(
                    valueListenable: filterState.selectedIndex,
                    builder: (context, selectedIndex, _) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return _buildCategoryChip(
                            categories[index],
                            selectedIndex == index,
                            theme,
                            () => filterState.selectCategory(index),
                          );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Coffee Grid
                Expanded(
                  child: ValueListenableBuilder<int>(
                    valueListenable: filterState.selectedIndex,
                    builder: (context, _, __) {
                      final filtered = filterState.filteredList;
                      return GridView.builder(
                        itemCount: filtered.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.68,
                        ),
                        itemBuilder: (ctx, index) {
                          final coffee = filtered[index];
                          return _buildCoffeeCard(coffee, theme);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(
      String label, bool selected, ThemeData theme, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Chip(
          label: Text(
            label,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: selected ? theme.colorScheme.primary : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: theme.colorScheme.primary),
        ),
      ),
    );
  }

  Widget _buildCoffeeCard(CoffeeModel coffee, ThemeData theme) {
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      elevation: isDarkMode ? 0 : 2,
      color: isDarkMode ? AppColors.darkCard : theme.colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: coffee),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'product-${coffee.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    coffee.imagePath,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                coffee.title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                coffee.subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDarkMode ? Colors.grey[400] : theme.hintColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      '\$ ${coffee.price}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      CartState().addToCart(coffee);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor:
                              isDarkMode ? AppColors.darkCard : Colors.white,
                          elevation: 4,
                          content: Row(
                            children: [
                              Icon(
                                IconlyBold.tick_square,
                                color: theme.colorScheme.primary,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Added to Cart',
                                      style:
                                          theme.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      coffee.title,
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        color: isDarkMode
                                            ? Colors.grey[400]
                                            : Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  IconlyLight.close_square,
                                  color: isDarkMode
                                      ? Colors.grey[400]
                                      : Colors.grey[600],
                                  size: 20,
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        IconlyBold.plus,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
