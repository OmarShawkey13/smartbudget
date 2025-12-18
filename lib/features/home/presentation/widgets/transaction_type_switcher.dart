import 'package:flutter/material.dart';
import 'package:smartbudget/core/theme/colors.dart';
import 'package:smartbudget/core/theme/text_styles.dart';

class TransactionTypeSwitcher extends StatelessWidget {
  final bool isExpense;
  final VoidCallback onExpenseTap;
  final VoidCallback onIncomeTap;

  const TransactionTypeSwitcher({
    super.key,
    required this.isExpense,
    required this.onExpenseTap,
    required this.onIncomeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: ColorsManager.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _TypeButton(
            label: 'Expense',
            active: isExpense,
            color: Colors.redAccent,
            onTap: onExpenseTap,
          ),
          _TypeButton(
            label: 'Income',
            active: !isExpense,
            color: Colors.green,
            onTap: onIncomeTap,
          ),
        ],
      ),
    );
  }
}

class _TypeButton extends StatelessWidget {
  final String label;
  final bool active;
  final Color color;
  final VoidCallback onTap;

  const _TypeButton({
    required this.label,
    required this.active,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? color : null,
            borderRadius: BorderRadius.circular(10),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStylesManager.bold14.copyWith(
              color: active ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
