import 'package:flutter/material.dart';
import 'package:smartbudget/core/theme/colors.dart';
import 'package:smartbudget/core/theme/text_styles.dart';
import 'package:smartbudget/core/utils/constants/spacing.dart';

class SummaryCard extends StatelessWidget {
  final double totalBalance;
  final double totalIncome;
  final double totalExpense;

  const SummaryCard({
    super.key,
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // Use primary color or gradient based on theme
        gradient: ColorsManager.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.primaryColor.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Balance',
            style: TextStylesManager.regular16.copyWith(
              color: ColorsManager.darkTextPrimary.withValues(alpha: 0.8),
            ),
          ),
          verticalSpace8,
          Text(
            '\$${totalBalance.toStringAsFixed(2)}',
            style: TextStylesManager.bold36.copyWith(
              color: ColorsManager.darkTextPrimary,
            ),
          ),
          verticalSpace24,
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  context,
                  icon: Icons.arrow_downward,
                  label: 'Income',
                  amount: totalIncome,
                  // You might want specific semantic colors here, or stick to theme
                  color: Colors
                      .greenAccent, // Or a color from your ColorsManager if exported
                  textColor: ColorsManager.darkTextPrimary,
                ),
              ),
              Container(width: 1, height: 40, color: Colors.grey),
              Expanded(
                child: _buildSummaryItem(
                  context,
                  icon: Icons.arrow_upward,
                  label: 'Expense',
                  amount: totalExpense,
                  color: Colors.redAccent,
                  textColor: ColorsManager.darkTextPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required double amount,
    required Color color,
    required Color textColor,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            horizontalSpace4,
            Text(
              label,
              style: TextStylesManager.regular14.copyWith(
                color: textColor.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
        verticalSpace4,
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStylesManager.medium18.copyWith(
            color: textColor,
          ),
        ),
      ],
    );
  }
}
