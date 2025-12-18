import 'package:flutter/material.dart';
import 'package:smartbudget/core/theme/colors.dart';
import 'package:smartbudget/core/utils/cubit/home_cubit.dart';

class RegisterNameField extends StatelessWidget {
  const RegisterNameField({super.key});

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
        controller: homeCubit.registerNameController,
        keyboardType: TextInputType.name,
        validator: (value) => value == null || value.trim().isEmpty
            ? 'Please enter your name'
            : null,
        decoration: const InputDecoration(
          hintText: 'Name',
          prefixIcon: Icon(
            Icons.person_outline,
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
