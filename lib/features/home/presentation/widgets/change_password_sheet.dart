import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbudget/core/theme/colors.dart';
import 'package:smartbudget/core/theme/text_styles.dart';
import 'package:smartbudget/core/utils/constants/spacing.dart';
import 'package:smartbudget/core/utils/cubit/home_cubit.dart';
import 'package:smartbudget/core/utils/cubit/home_state.dart';

class ChangePasswordSheet extends StatelessWidget {
  const ChangePasswordSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // Pre-fill the email controller with the current user's email
    if (user?.email != null) {
      homeCubit.resetPasswordEmailController.text = user!.email!;
    }

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      decoration: BoxDecoration(
        color: ColorsManager.cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          verticalSpace20,

          Text(
            'Change Password',
            style: TextStylesManager.bold20.copyWith(
              color: ColorsManager.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          verticalSpace10,
          Text(
            'We will send a password reset link to your registered email.',
            style: TextStylesManager.regular14.copyWith(
              color: ColorsManager.textSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          verticalSpace24,

          // Display Email (Read-only)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorsManager.backgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorsManager.textColor.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.email_outlined,
                  color: ColorsManager.textSecondaryColor,
                ),
                horizontalSpace12,
                Expanded(
                  child: Text(
                    user?.email ?? 'No Email',
                    style: TextStylesManager.medium16.copyWith(
                      color: ColorsManager.textColor,
                    ),
                  ),
                ),
                const Icon(
                  Icons.check_circle,
                  color: ColorsManager.primary,
                  size: 20,
                ),
              ],
            ),
          ),

          verticalSpace24,

          BlocConsumer<HomeCubit, HomeStates>(
            listener: (context, state) {
              if (state is HomeResetPasswordSuccessState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Reset link sent! Check your email.'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is HomeResetPasswordErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is HomeResetPasswordLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                onPressed: () {
                  homeCubit.resetPassword();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: ColorsManager.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Send Reset Link',
                  style: TextStylesManager.bold16.copyWith(color: Colors.white),
                ),
              );
            },
          ),
          verticalSpace10,
        ],
      ),
    );
  }
}
