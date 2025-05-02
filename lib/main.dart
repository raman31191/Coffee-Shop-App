import 'package:coffeeshop_app/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:coffeeshop_app/theme/app_theme.dart';
import 'package:coffeeshop_app/state/theme_state.dart';

void main() {
  runApp(const CoffeeShopApp());
}

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeState,
      builder: (context, currentMode, _) {
        return MaterialApp(
          title: 'Coffee Shop App',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: currentMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
