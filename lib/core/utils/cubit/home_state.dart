import 'package:firebase_auth/firebase_auth.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeChangeThemeState extends HomeStates {}

class HomeShowPasswordUpdatedState extends HomeStates {}

class HomeChangeBottomNavState extends HomeStates {} // New State

//login
class HomeLoginLoadingState extends HomeStates {}

class HomeLoginSuccessState extends HomeStates {
  final User? user;

  HomeLoginSuccessState(this.user);
}

class HomeLoginErrorState extends HomeStates {
  final String error;

  HomeLoginErrorState(this.error);
}

//register
class HomeProfileImagePickedState extends HomeStates {}

class HomeRegisterLoadingState extends HomeStates {}

class HomeRegisterSuccessState extends HomeStates {
  final User? user;

  HomeRegisterSuccessState(this.user);
}

class HomeRegisterErrorState extends HomeStates {
  final String error;

  HomeRegisterErrorState(this.error);
}

// Transactions Data
class HomeTransactionsLoadingState extends HomeStates {}

class HomeTransactionsLoadedState extends HomeStates {}

class HomeTransactionsErrorState extends HomeStates {
  final String error;

  HomeTransactionsErrorState(this.error);
}

class HomeAddTransactionSuccessState extends HomeStates {}

class HomeTransactionAddErrorState extends HomeStates {
  final String error;

  HomeTransactionAddErrorState(this.error);
}

class HomeDeleteTransactionSuccessState extends HomeStates {}

class HomeTransactionDeleteErrorState extends HomeStates {
  final String error;

  HomeTransactionDeleteErrorState(this.error);
}

// Add Transaction Form States (New Logic)
class HomeNewTransactionTypeChangedState extends HomeStates {}

class HomeNewTransactionCategoryChangedState extends HomeStates {}

// Reset Password States
class HomeResetPasswordLoadingState extends HomeStates {}

class HomeResetPasswordSuccessState extends HomeStates {}

class HomeResetPasswordErrorState extends HomeStates {
  final String error;

  HomeResetPasswordErrorState(this.error);
}

// Change Password States
class HomeChangePasswordLoadingState extends HomeStates {}

class HomeChangePasswordSuccessState extends HomeStates {}

class HomeChangePasswordErrorState extends HomeStates {
  final String error;

  HomeChangePasswordErrorState(this.error);
}
