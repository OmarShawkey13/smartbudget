import 'package:flutter/material.dart';
import 'package:smartbudget/core/theme/colors.dart';
import 'package:smartbudget/core/theme/text_styles.dart';
import 'package:smartbudget/core/utils/constants/spacing.dart';
import 'package:smartbudget/core/utils/extensions/context_extension.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'About Us',
          style: TextStylesManager.bold20,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: colorScheme.onSurface,
          ),
          onPressed: () => context.pop,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace20,

            // --- Logo Section ---
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: ColorsManager.primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.account_balance_wallet_rounded,
                size: 60,
                color: Colors.white,
              ),
            ),

            verticalSpace24,

            // --- App Name & Version ---
            Text(
              'Smart Budget',
              style: TextStylesManager.bold24.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            verticalSpace8,
            Text(
              'Version 1.0.0',
              style: TextStylesManager.regular14.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withValues(
                  alpha: 0.6,
                ),
              ),
            ),

            verticalSpace40,

            // --- Description ---
            Text(
              'Take Control of Your Finances',
              style: TextStylesManager.bold18.copyWith(
                color: colorScheme.primary,
              ),
            ),
            verticalSpace12,
            Text(
              'Smart Budget is designed to help you track your income and expenses effortlessly. We believe that financial freedom starts with understanding where your money goes. Our goal is to provide a simple, secure, and intuitive platform for your daily financial needs.',
              textAlign: TextAlign.center,
              style: TextStylesManager.regular16.copyWith(
                color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.8),
                height: 1.5,
              ),
            ),

            verticalSpace40,

            // --- Features Grid ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeatureItem(
                  context,
                  icon: Icons.security_rounded,
                  title: 'Secure',
                  color: Colors.green,
                ),
                _buildFeatureItem(
                  context,
                  icon: Icons.flash_on_rounded,
                  title: 'Fast',
                  color: Colors.orange,
                ),
                _buildFeatureItem(
                  context,
                  icon: Icons.insights_rounded,
                  title: 'Smart',
                  color: Colors.blue,
                ),
              ],
            ),

            verticalSpace60,

            // --- Footer ---
            Divider(color: theme.dividerColor.withValues(alpha: 0.2)),
            verticalSpace20,
            Text(
              'Developed with ❤️ for better future.',
              style: TextStylesManager.medium12.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withValues(
                  alpha: 0.5,
                ),
              ),
            ),
            verticalSpace10,
            Text(
              '© ${DateTime.now().year} Smart Budget. All rights reserved.',
              style: TextStylesManager.regular10.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withValues(
                  alpha: 0.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        verticalSpace12,
        Text(
          title,
          style: TextStylesManager.medium14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
