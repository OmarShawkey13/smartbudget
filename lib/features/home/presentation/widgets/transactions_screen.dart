import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbudget/core/theme/text_styles.dart';
import 'package:smartbudget/core/utils/constants/spacing.dart';
import 'package:smartbudget/core/utils/cubit/home_cubit.dart';
import 'package:smartbudget/core/utils/cubit/home_state.dart';
import 'package:smartbudget/features/home/presentation/widgets/chart_section.dart';
import 'package:smartbudget/features/home/presentation/widgets/summary_card.dart';
import 'package:smartbudget/features/home/presentation/widgets/transaction_item.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) {
        return current is HomeAddTransactionSuccessState ||
            current is HomeDeleteTransactionSuccessState ||
            current is HomeTransactionsLoadingState ||
            current is HomeTransactionsErrorState ||
            current is HomeTransactionsLoadedState;
      },
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace24,

              SummaryCard(
                totalBalance: homeCubit.totalBalance,
                totalIncome: homeCubit.totalIncome,
                totalExpense: homeCubit.totalExpense,
              ),

              verticalSpace24,

              // Chart Section Container
              if (homeCubit.categoryExpenses.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ChartSection(cubit: homeCubit),
                ),
                verticalSpace24,
              ],

              Text(
                'Transactions',
                style: TextStylesManager.bold20.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              verticalSpace12,

              homeCubit.transactions.isEmpty
                  ? _buildEmptyState(context)
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: homeCubit.transactions.length,
                      separatorBuilder: (c, i) => verticalSpace12,
                      itemBuilder: (context, index) {
                        final transaction = homeCubit.transactions[index];
                        return TransactionItem(
                          transaction: transaction,
                          cubit: homeCubit,
                        );
                      },
                    ),
              verticalSpace80,
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                Icons.receipt_long_rounded,
                size: 40,
                color: Colors.grey[400],
              ),
            ),
            verticalSpace16,
            Text(
              'No transactions yet',
              style: TextStylesManager.regular16.copyWith(
                color: Colors.grey[500],
              ),
            ),
            verticalSpace8,
            Text(
              'Start adding your expenses!',
              style: TextStylesManager.regular14.copyWith(
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
