import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartbudget/core/models/transaction_model.dart';
import 'package:smartbudget/core/theme/text_styles.dart';
import 'package:smartbudget/core/utils/constants/spacing.dart';
import 'package:smartbudget/core/utils/cubit/home_cubit.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;
  final HomeCubit cubit;

  const TransactionItem({
    super.key,
    required this.transaction,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isExpense = transaction.type == 'expense';

    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.delete, color: colorScheme.onErrorContainer),
      ),
      onDismissed: (_) {
        cubit.deleteTransaction(transaction.id);
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardTheme.color ?? colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isExpense
                  ? Colors.red.withValues(alpha: 0.1)
                  : Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getCategoryIcon(transaction.category),
              color: isExpense ? Colors.red : Colors.green,
            ),
          ),
          title: Text(
            transaction.category,
            style: TextStylesManager.bold16,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              DateFormat('MMM d, y').format(transaction.date),
              style: TextStylesManager.regular12.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withValues(
                  alpha: 0.7,
                ),
              ),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${isExpense ? "-" : "+"}\$${transaction.amount.toStringAsFixed(2)}',
                style: TextStylesManager.bold16.copyWith(
                  color: isExpense ? Colors.red : Colors.green,
                ),
              ),
              horizontalSpace8,
              // زر الحذف الجديد
              InkWell(
                onTap: () {
                  // يمكن إضافة حوار تأكيد (Confirmation Dialog) هنا إذا أردت
                  cubit.deleteTransaction(transaction.id);
                },
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red.withValues(alpha: 0.6),
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.fastfood_rounded;
      case 'Transport':
        return Icons.directions_car_rounded;
      case 'Shopping':
        return Icons.shopping_bag_rounded;
      case 'Health':
        return Icons.medical_services_rounded;
      case 'Bills':
        return Icons.receipt_long_rounded;
      case 'Entertainment':
        return Icons.movie_creation_rounded;
      case 'Education':
        return Icons.school_rounded;
      case 'Salary':
        return Icons.monetization_on_rounded;
      case 'Business':
        return Icons.business_center_rounded;
      case 'Investment':
        return Icons.trending_up_rounded;
      case 'Gift':
        return Icons.card_giftcard_rounded;
      case 'Bonus':
        return Icons.stars_rounded;
      default:
        return Icons.category_rounded;
    }
  }
}
