import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffeeshop_app/screens/loginscreen.dart'; // update path as needed
import 'package:coffeeshop_app/theme/app_theme.dart'; // if your theme is in a separate file

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    setState(() {
      isDarkMode = value;
    });
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primaryColor.withOpacity(0.2),
            child: const Icon(
              IconlyBold.profile,
              size: 40,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Coffee Lover',
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              'user@coffee.com',
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 32),

          // Dark Mode Toggle
          ListTile(
            leading: const Icon(IconlyLight.show),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: isDarkMode,
              activeColor: AppColors.primaryColor,
              onChanged: (val) => _toggleTheme(val),
            ),
          ),

          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(IconlyLight.logout),
            title: const Text('Logout'),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
