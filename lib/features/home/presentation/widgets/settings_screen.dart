import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbudget/core/theme/colors.dart';
import 'package:smartbudget/core/theme/text_styles.dart';
import 'package:smartbudget/core/utils/constants/routes.dart';
import 'package:smartbudget/core/utils/constants/spacing.dart';
import 'package:smartbudget/core/utils/cubit/home_cubit.dart';
import 'package:smartbudget/core/utils/cubit/home_state.dart';
import 'package:smartbudget/core/utils/extensions/context_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartbudget/features/home/presentation/widgets/change_password_sheet.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (_, state) => state is HomeChangeThemeState,
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace24,

              // Theme Switcher Tile
              _buildSettingsTile(
                context,
                icon: homeCubit.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                title: 'Dark Mode',
                trailing: Switch(
                  value: homeCubit.isDarkMode,
                  onChanged: (value) {
                    homeCubit.changeTheme();
                  },
                ),
              ),

              verticalSpace16,

              // Change Password Tile
              _buildSettingsTile(
                context,
                icon: Icons.lock_reset_rounded,
                title: 'Change Password',
                onTap: () {
                  showModalBottomSheet<Object>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (ctx) => const ChangePasswordSheet(),
                  );
                },
              ),

              verticalSpace16,

              _buildSettingsTile(
                context,
                icon: Icons.info_outline_rounded,
                title: 'About Us',
                onTap: () {
                  context.push<Object>(Routes.about);
                },
              ),

              verticalSpace16,

              // Logout Tile
              _buildSettingsTile(
                context,
                icon: Icons.logout,
                title: 'Logout',
                textColor: Colors.red,
                iconColor: Colors.red,
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    context.pushReplacement<Object>(Routes.login);
                  }
                  homeCubit.currentIndex = 0;
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: ColorsManager.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (iconColor ?? ColorsManager.textColor).withValues(
              alpha: 0.1,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor ?? ColorsManager.textColor,
          ),
        ),
        title: Text(
          title,
          style: TextStylesManager.medium16.copyWith(
            color: textColor ?? ColorsManager.textColor,
          ),
        ),
        trailing:
            trailing ??
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }
}
