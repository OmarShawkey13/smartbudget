import 'package:flutter/material.dart';
import 'package:smartbudget/core/theme/colors.dart';
import 'package:smartbudget/core/theme/text_styles.dart';
import 'package:smartbudget/core/utils/constants/spacing.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        verticalSpace30,
        Text(
          'Smart Budget',
          style: TextStylesManager.bold26.copyWith(
            color: ColorsManager.textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
