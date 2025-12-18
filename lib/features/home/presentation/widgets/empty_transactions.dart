import 'package:flutter/material.dart';
import 'package:smartbudget/core/theme/text_styles.dart';
import 'package:smartbudget/core/utils/constants/spacing.dart';

class EmptyTransactions extends StatelessWidget {
  const EmptyTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 80,
            color: Colors.grey[300],
          ),
          verticalSpace16,
          Text(
            'No transactions yet',
            style: TextStylesManager.regular16.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
