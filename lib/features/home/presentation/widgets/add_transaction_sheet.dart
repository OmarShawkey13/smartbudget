import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbudget/core/theme/colors.dart';
import 'package:smartbudget/core/theme/text_styles.dart';
import 'package:smartbudget/core/utils/constants/spacing.dart';
import 'package:smartbudget/core/utils/cubit/home_cubit.dart';
import 'package:smartbudget/core/utils/cubit/home_state.dart';
import 'package:smartbudget/features/home/presentation/widgets/transaction_type_switcher.dart';

class AddTransactionSheet extends StatefulWidget {
  const AddTransactionSheet({super.key});

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  @override
  void initState() {
    super.initState();
    homeCubit.initNewTransactionForm();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) {
        return current is HomeNewTransactionTypeChangedState ||
            current is HomeNewTransactionCategoryChangedState ||
            current is HomeChangeThemeState;
      },
      builder: (context, state) {
        final isExpense = homeCubit.newTransType == 'expense';
        return Container(
          decoration: BoxDecoration(
            color: ColorsManager.cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SingleChildScrollView(
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
                  'New Transaction',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpace20,

                /// TYPE SWITCH
                TransactionTypeSwitcher(
                  isExpense: isExpense,
                  onExpenseTap: () {
                    homeCubit.changeNewTransactionType('expense');
                  },
                  onIncomeTap: () {
                    homeCubit.changeNewTransactionType('income');
                  },
                ),

                verticalSpace20,

                /// AMOUNT
                TextFormField(
                  controller: homeCubit.newTransAmountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    hintText: '0.00',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.attach_money),
                  ),
                ),

                verticalSpace16,

                /// CATEGORY
                DropdownButtonFormField<String>(
                  key: ValueKey(homeCubit.newTransType),
                  initialValue: homeCubit.newTransCategory,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.category_outlined),
                  ),
                  items:
                      (isExpense
                              ? homeCubit.expenseCategories
                              : homeCubit.incomeCategories)
                          .map(
                            (c) => DropdownMenuItem(value: c, child: Text(c)),
                          )
                          .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      homeCubit.changeNewTransactionCategory(val);
                    }
                  },
                ),

                verticalSpace24,

                /// SAVE BUTTON
                ElevatedButton(
                  onPressed: () => homeCubit.saveNewTransaction(context),
                  child: Text(
                    'Save Transaction',
                    style: TextStylesManager.bold16.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                verticalSpace10,
              ],
            ),
          ),
        );
      },
    );
  }
}
