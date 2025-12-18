import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbudget/core/theme/colors.dart';
import 'package:smartbudget/core/theme/text_styles.dart';
import 'package:smartbudget/core/utils/cubit/home_cubit.dart';
import 'package:smartbudget/core/utils/cubit/home_state.dart';
import 'package:smartbudget/features/home/presentation/widgets/add_transaction_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    homeCubit.getTransactions();
  }

  void _showAddTransactionSheet(BuildContext context) {
    showModalBottomSheet<Object>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return const AddTransactionSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) {
        return current is HomeChangeBottomNavState ||
            current is HomeChangeThemeState;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Smart Budget',
              style: TextStylesManager.bold24,
            ),
          ),
          body: homeCubit.pages[homeCubit.currentIndex],
          floatingActionButton: homeCubit.currentIndex == 0
              ? FloatingActionButton(
                  onPressed: () => _showAddTransactionSheet(context),
                  child: const Icon(Icons.add, color: Colors.white),
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: homeCubit.currentIndex,
            onTap: (index) {
              homeCubit.currentIndex = index;
            },
            backgroundColor: ColorsManager.backgroundColor,
            selectedItemColor: ColorsManager.primaryColor,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            elevation: 8,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
