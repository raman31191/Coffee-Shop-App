import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffeeshop_app/state/theme_state.dart';
import 'package:coffeeshop_app/screens/loginscreen.dart';
import 'package:coffeeshop_app/theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 20),

            // 🧍 Avatar
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                child: Icon(
                  IconlyBold.profile,
                  size: 48,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 👤 Name
            Center(
              child: Text(
                'Coffee Lover',
                style: GoogleFonts.sora(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onBackground,
                ),
              ),
            ),
            Center(
              child: Text(
                'user@coffee.com',
                style: GoogleFonts.sora(
                  fontSize: 14,
                  color: colorScheme.onBackground.withOpacity(0.7),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // 🌙 Dark Mode Card
            _buildCardTile(
              context: context,
              icon: IconlyLight.show,
              title: 'Dark Mode',
              trailing: Switch(
                value: isDark,
                activeColor: AppColors.primaryColor,
                onChanged: (_) => themeState.toggleTheme(),
              ),
            ),

            const SizedBox(height: 12),

            // 🚪 Logout Card
            _buildCardTile(
              context: context,
              icon: IconlyLight.logout,
              title: 'Logout',
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Icon(icon, color: AppColors.primaryColor),
        title: Text(
          title,
          style: GoogleFonts.sora(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }
}
