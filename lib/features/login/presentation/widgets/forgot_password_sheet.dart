import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbudget/core/theme/colors.dart';
import 'package:smartbudget/core/theme/text_styles.dart';
import 'package:smartbudget/core/utils/constants/spacing.dart';
import 'package:smartbudget/core/utils/cubit/home_cubit.dart';
import 'package:smartbudget/core/utils/cubit/home_state.dart';
import 'package:smartbudget/core/utils/extensions/context_extension.dart';

class ForgotPasswordSheet extends StatelessWidget {
  const ForgotPasswordSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Reset Password',
            style: TextStylesManager.bold20,
            textAlign: TextAlign.center,
          ),
          verticalSpace10,
          Text(
            'Enter your email to receive a password reset link.',
            style: TextStylesManager.regular14.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          verticalSpace20,
          TextField(
            controller: homeCubit.resetPasswordEmailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email Address',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          verticalSpace20,
          BlocConsumer<HomeCubit, HomeStates>(
            listener: (context, state) {
              if (state is HomeResetPasswordSuccessState) {
                context.pop; // Close sheet
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Password reset link sent! Check your email.',
                    ),
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
            buildWhen: (_, state) =>
                state is HomeResetPasswordLoadingState ||
                state is HomeResetPasswordSuccessState ||
                state is HomeResetPasswordErrorState,
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
