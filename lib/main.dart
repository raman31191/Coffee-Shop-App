import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffeeshop_app/screens/splashscreen.dart';
import 'package:coffeeshop_app/theme/app_theme.dart';
import 'package:coffeeshop_app/state/theme_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load theme mode from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  themeState.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;

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
