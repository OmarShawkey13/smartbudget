import 'package:flutter/material.dart';
import 'package:smartbudget/core/theme/colors.dart';
import 'package:smartbudget/core/utils/cubit/home_cubit.dart';

class RegisterEmailField extends StatelessWidget {
  const RegisterEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = homeCubit.isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: .05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: TextFormField(
        controller: homeCubit.registerEmailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
        decoration: const InputDecoration(
          hintText: 'Email',
          prefixIcon: Icon(
            Icons.email_rounded,
            color: ColorsManager.primary,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}
