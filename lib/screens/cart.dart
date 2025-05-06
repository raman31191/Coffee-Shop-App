import 'package:flutter/material.dart';
import 'package:coffeeshop_app/models/coffeecard.dart';
import 'package:iconly/iconly.dart';
import 'package:coffeeshop_app/screens/homescreen.dart';
import 'package:coffeeshop_app/state/cart_state.dart';
import 'package:coffeeshop_app/theme/app_theme.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback? onCheckoutSuccess;

  const CartScreen({
    super.key,
    this.onCheckoutSuccess,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get totalPrice {
    final cartItems = CartState().cartItems;
    return cartItems.entries.fold(0.0, (sum, entry) {
      return sum +
          double.parse(entry.key.price.replaceAll('\$', '')) * entry.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : AppColors.textDark,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : AppColors.textDark,
        ),
        leading: IconButton(
          icon: const Icon(IconlyLight.arrow_left_circle),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: ListenableBuilder(
        listenable: CartState(),
        builder: (context, _) {
          final cartItems = CartState().cartItems;
          if (cartItems.isEmpty) {
            return _buildEmptyCart(theme, isDarkMode);
          }

          return Column(
            children: [
              // Scrollable list of cart items
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  itemCount: cartItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final coffee = cartItems.keys.elementAt(index);
                    final quantity = cartItems[coffee]!;
                    return _buildCartItem(
                        coffee, theme, quantity, index, isDarkMode);
                  },
                ),
              ),
              // Checkout panel
              _buildCheckoutPanel(theme, isDarkMode),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart(ThemeData theme, bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconlyLight.bag,
            size: 64,
            color: isDarkMode ? Colors.grey[400] : theme.disabledColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: theme.textTheme.titleMedium?.copyWith(
              color: isDarkMode ? Colors.grey[400] : theme.disabledColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Browse our menu and add some items',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDarkMode ? Colors.grey[400] : AppColors.textDark,
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: theme.colorScheme.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Explore Menu',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(
    CoffeeModel coffee,
    ThemeData theme,
    int quantity,
    int index,
    bool isDarkMode,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            coffee.imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          coffee.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : AppColors.textDark,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              coffee.subtitle, // This is your "Ice/Hot" text
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDarkMode ? Colors.grey[300] : theme.hintColor,
              ),
            ),
            Text(
              'Hot', // Temperature selection
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDarkMode ? Colors.grey[300] : theme.hintColor,
              ),
            ),
          ],
        ),
        trailing: SizedBox(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                coffee.price,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : AppColors.textDark,
                ),
              ),
              SizedBox(
                height: 24,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        IconlyLight.delete,
                        size: 18,
                        color:
                            isDarkMode ? Colors.grey[300] : AppColors.textDark,
                      ),
                      onPressed: () => CartState().removeFromCart(coffee),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    Text(
                      quantity.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? Colors.white : AppColors.textDark,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        IconlyLight.plus,
                        size: 18,
                        color:
                            isDarkMode ? Colors.grey[300] : AppColors.textDark,
                      ),
                      onPressed: () => CartState().addToCart(coffee),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckoutPanel(ThemeData theme, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkCard : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.1),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Subtotal Row
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDarkMode ? Colors.grey[300] : AppColors.textDark,
                  ),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDarkMode ? Colors.white : AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
          // Delivery Row
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDarkMode ? Colors.grey[300] : AppColors.textDark,
                  ),
                ),
                Text(
                  '\$0.00',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDarkMode ? Colors.white : AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 24,
            color: Colors.grey, // Visible in both light and dark modes
          ),
          // Total Row
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : AppColors.textDark,
                  ),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: CartState().cartItems.isEmpty
                ? null
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor:
                            isDarkMode ? AppColors.darkCard : Colors.white,
                        content: Text(
                          'Order placed successfully!',
                          style: TextStyle(
                            color:
                                isDarkMode ? Colors.white : AppColors.textDark,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    widget.onCheckoutSuccess?.call();
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
