import 'package:flutter/material.dart';
import 'package:smartbudget/features/entry/presentation/screen/entry_screen.dart';
import 'package:smartbudget/features/home/presentation/screen/home_screen.dart';
import 'package:smartbudget/features/home/presentation/widgets/about_screen.dart';
import 'package:smartbudget/features/login/presentation/screen/login_screen.dart';
import 'package:smartbudget/features/register/presentation/screen/register_screen.dart';

class Routes {
  static const String entry = "/entry";
  static const String login = "/login";
  static const String register = "/register";
  static const String home = "/home";
  static const String about = "/about";

  static Map<String, WidgetBuilder> get routes => {
    entry: (context) => const EntryScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    home: (context) => const HomeScreen(),
    about: (context) => const AboutScreen(),
  };
}
