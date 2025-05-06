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
                'User',
                style: GoogleFonts.sora(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onBackground,
                ),
              ),
            ),
            Center(
              child: Text(
                'user@example.com',
                style: GoogleFonts.sora(
                  fontSize: 14,
                  color: colorScheme.onBackground.withOpacity(0.7),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // 🌙 Dark Mode
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

            // 📞 Contact Us
            _buildCardTile(
              context: context,
              icon: Icons.phone_outlined,
              title: 'Contact Us',
              onTap: () {
                // Add your contact logic here
                showDialog(
                  context: context,
                  builder: (_) {
                    final colorScheme = Theme.of(context).colorScheme;
                    final textTheme = Theme.of(context).textTheme;

                    return AlertDialog(
                      backgroundColor: colorScheme.surface,
                      titleTextStyle: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      contentTextStyle: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.8),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      title: const Text('Contact Us'),
                      content: const Text('Email us at support@coffeeshop.com'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'OK',
                            style: textTheme.labelLarge
                                ?.copyWith(color: colorScheme.primary),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 12),

            // ℹ️ About Us
            _buildCardTile(
              context: context,
              icon: Icons.info_outline,
              title: 'About Us',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    final colorScheme = Theme.of(context).colorScheme;
                    final textTheme = Theme.of(context).textTheme;

                    return AlertDialog(
                      backgroundColor: colorScheme.surface,
                      titleTextStyle: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      contentTextStyle: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.8),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      title: const Text('About Us'),
                      content: const Text(
                          'CoffeeShop App is your companion in finding the perfect coffee. '
                          'We’re passionate about great taste and smooth experiences.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'OK',
                            style: textTheme.labelLarge
                                ?.copyWith(color: colorScheme.primary),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 12),

            // 📄 Terms & Conditions
            _buildCardTile(
              context: context,
              icon: Icons.description_outlined,
              title: 'Terms & Conditions',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    final colorScheme = Theme.of(context).colorScheme;
                    final textTheme = Theme.of(context).textTheme;

                    return AlertDialog(
                      backgroundColor: colorScheme.surface,
                      titleTextStyle: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      contentTextStyle: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.8),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      title: const Text('Terms & Conditions'),
                      content: const Text(
                          'By using this app, you agree to our terms of service and privacy policies. '
                          'Please read them carefully before proceeding.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'OK',
                            style: textTheme.labelLarge
                                ?.copyWith(color: colorScheme.primary),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 12),

            // 🚪 Logout
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
