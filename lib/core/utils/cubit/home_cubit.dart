import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbudget/core/models/transaction_model.dart';
import 'package:smartbudget/core/models/user_model.dart';
import 'package:smartbudget/core/network/local/cache_helper.dart';
import 'package:smartbudget/core/network/user_repository.dart';
import 'package:smartbudget/core/utils/cubit/home_state.dart';
import 'package:smartbudget/core/utils/extensions/context_extension.dart';
import 'package:smartbudget/features/home/presentation/widgets/transactions_screen.dart';
import 'package:smartbudget/features/home/presentation/widgets/settings_screen.dart';
import 'package:smartbudget/main.dart';
import 'package:uuid/uuid.dart';

HomeCubit get homeCubit => HomeCubit.get(navigatorKey.currentContext!);

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void changeTheme({bool? fromShared}) {
    _isDarkMode = fromShared ?? !_isDarkMode;
    CacheHelper.saveData(key: 'isDark', value: _isDarkMode);
    emit(HomeChangeThemeState());
  }

  //login
  final Map<String, bool> _passwordVisibility = {
    'login': false,
    'register': false,
  };

  Map<String, bool> get passwordVisibility => _passwordVisibility;

  void togglePasswordVisibility(String key) {
    _passwordVisibility[key] = !_passwordVisibility[key]!;
    emit(HomeShowPasswordUpdatedState());
  }

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final UserRepository userRepo = UserRepository();

  Future<void> login() async {
    emit(HomeLoginLoadingState());
    final email = loginEmailController.text.trim();
    final password = loginPasswordController.text.trim();
    try {
      final user = await _signInUser(email, password);
      final refreshedUser = await _reloadUser(user);
      emit(HomeLoginSuccessState(refreshedUser));
    } on FirebaseAuthException catch (e) {
      emit(HomeLoginErrorState(_mapAuthError(e)));
    } catch (e) {
      emit(HomeLoginErrorState("Something went wrong. Please try again."));
    }
  }

  /// ------------------ HELPERS ------------------

  Future<User> _signInUser(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user!;
  }

  Future<User> _registerUser(String email, String password) async {
    final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return res.user!;
  }

  Future<User> _reloadUser(User user) async {
    await user.reload();
    return FirebaseAuth.instance.currentUser!;
  }

  Future<void> _createUserInFirestore(User user) async {
    final userModel = UserModel(
      uid: user.uid,
      email: user.email!,
      username: registerNameController.text.trim(),
    );

    await userRepo.createUser(userModel);
  }

  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();

  Future<void> register() async {
    emit(HomeRegisterLoadingState());

    final email = registerEmailController.text.trim();
    final password = registerPasswordController.text.trim();

    try {
      final user = await _registerUser(email, password);
      await _createUserInFirestore(user);

      emit(HomeRegisterSuccessState(user));
      registerNameController.clear();
      registerEmailController.clear();
      registerPasswordController.clear();
    } on FirebaseAuthException catch (e) {
      emit(HomeRegisterErrorState(_mapAuthError(e)));
    } catch (e) {
      emit(HomeRegisterErrorState("Something went wrong. Please try again."));
    }
  }

  String _mapAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'Password should be at least 8 characters.';
      case 'invalid-email':
        return 'Invalid email address.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }

  // Transactions Logic
  List<TransactionModel> transactions = [];
  Map<String, double> categoryExpenses = {};
  double totalBalance = 0.0;
  double totalIncome = 0.0;
  double totalExpense = 0.0;

  void calculateTotals() {
    totalIncome = 0.0;
    totalExpense = 0.0;
    categoryExpenses.clear();

    for (var transaction in transactions) {
      if (transaction.type == 'income') {
        totalIncome += transaction.amount;
      } else {
        totalExpense += transaction.amount;
        if (categoryExpenses.containsKey(transaction.category)) {
          categoryExpenses[transaction.category] =
              categoryExpenses[transaction.category]! + transaction.amount;
        } else {
          categoryExpenses[transaction.category] = transaction.amount;
        }
      }
    }
    totalBalance = totalIncome - totalExpense;
  }

  Future<void> getTransactions() async {
    emit(HomeTransactionsLoadingState());
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(HomeTransactionsErrorState("User not logged in"));
      return;
    }

    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('transactions')
          .orderBy('date', descending: true)
          .snapshots()
          .listen((snapshot) {
            transactions = snapshot.docs
                .map((doc) => TransactionModel.fromMap(doc.data()))
                .toList();
            calculateTotals();
            emit(HomeTransactionsLoadedState());
          });
    } catch (e) {
      emit(HomeTransactionsErrorState(e.toString()));
    }
  }

  Future<void> addTransaction({
    required double amount,
    required String type,
    required String category,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final id = const Uuid().v4();
    final transaction = TransactionModel(
      id: id,
      amount: amount,
      date: DateTime.now(),
      type: type,
      category: category,
    );

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('transactions')
          .doc(id)
          .set(transaction.toMap());
      // The stream listener will update the UI
      emit(HomeAddTransactionSuccessState());
    } catch (e) {
      emit(HomeTransactionAddErrorState(e.toString()));
    }
  }

  Future<void> deleteTransaction(String id) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('transactions')
          .doc(id)
          .delete();
      emit(HomeDeleteTransactionSuccessState());
    } catch (e) {
      emit(HomeTransactionDeleteErrorState(e.toString()));
    }
  }

  // ------------------ NEW TRANSACTION FORM LOGIC ------------------

  final TextEditingController newTransAmountController =
      TextEditingController();

  String newTransType = 'expense';
  String newTransCategory = 'Food'; // Default initial category

  final List<String> expenseCategories = const [
    'Food',
    'Transport',
    'Shopping',
    'Health',
    'Bills',
    'Entertainment',
    'Education',
    'Other',
  ];

  final List<String> incomeCategories = const [
    'Salary',
    'Business',
    'Investment',
    'Gift',
    'Bonus',
    'Other',
  ];

  void initNewTransactionForm() {
    newTransAmountController.clear();
    newTransType = 'expense';
    newTransCategory = expenseCategories.first;
    // No emit needed here usually, unless the UI is already listening
  }

  void changeNewTransactionType(String type) {
    newTransType = type;
    // Reset category to the first of the new type list
    if (newTransType == 'expense') {
      newTransCategory = expenseCategories.first;
    } else {
      newTransCategory = incomeCategories.first;
    }
    emit(HomeNewTransactionTypeChangedState());
  }

  void changeNewTransactionCategory(String category) {
    newTransCategory = category;
    emit(HomeNewTransactionCategoryChangedState());
  }

  void saveNewTransaction(BuildContext context) {
    final amount = double.tryParse(newTransAmountController.text) ?? 0.0;

    if (amount > 0) {
      addTransaction(
        amount: amount,
        type: newTransType,
        category: newTransCategory,
      );
      context.pop;
    }
  }

  // ------------------ RESET PASSWORD LOGIC ------------------

  final TextEditingController resetPasswordEmailController =
      TextEditingController();

  Future<void> resetPassword() async {
    final email = resetPasswordEmailController.text.trim();
    if (email.isEmpty) {
      emit(HomeResetPasswordErrorState('Please enter your email.'));
      return;
    }

    emit(HomeResetPasswordLoadingState());

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(HomeResetPasswordSuccessState());
      resetPasswordEmailController.clear();
    } on FirebaseAuthException catch (e) {
      String errorMsg = 'Failed to send reset email.';
      if (e.code == 'user-not-found') {
        errorMsg = 'No user found with this email.';
      } else if (e.code == 'invalid-email') {
        errorMsg = 'Invalid email address.';
      }
      emit(HomeResetPasswordErrorState(errorMsg));
    } catch (e) {
      emit(HomeResetPasswordErrorState(e.toString()));
    }
  }

  // ------------------ BOTTOM NAV LOGIC ------------------

  final List<Widget> pages = [
    const TransactionsScreen(),
    const SettingsScreen(),
  ];

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    emit(HomeChangeBottomNavState());
  }
}
