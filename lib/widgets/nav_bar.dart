import 'package:flutter/material.dart';
import 'package:coffeeshop_app/theme/app_theme.dart';
import 'package:coffeeshop_app/state/cart_state.dart';
import 'package:iconly/iconly.dart';

class CustomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late final CartState _cartState;
  late VoidCallback _cartListener;

  @override
  void initState() {
    super.initState();
    _cartState = CartState();

    // Listener to update badge count when cart changes
    _cartListener = () => setState(() {});
    _cartState.addListener(_cartListener);
  }

  @override
  void dispose() {
    _cartState.removeListener(_cartListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final totalItems =
        _cartState.cartItems.values.fold(0, (sum, quantity) => sum + quantity);

    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: theme.scaffoldBackgroundColor,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: isDark ? Colors.grey[600] : Colors.grey[500],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(IconlyLight.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(IconlyLight.heart),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 28,
            height: 28,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Icon(IconlyLight.buy),
                ),
                if (totalItems > 0)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Container(
                        key: ValueKey<int>(totalItems),
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$totalItems',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: Icon(IconlyLight.profile),
          label: 'Profile',
        ),
      ],
    );
  }
}
