import 'package:flutter/material.dart';
import 'package:smartbudget/features/entry/presentation/screen/entry_screen.dart';
import 'package:smartbudget/features/home/presentation/screen/home_screen.dart';
import 'package:smartbudget/features/home/presentation/widgets/about_screen.dart';
import 'package:smartbudget/features/login/presentation/screen/login_screen.dart';
import 'package:smartbudget/features/register/presentation/screen/register_screen.dart';

/// **مدير المسارات (Routes Manager)**
/// هذا الكلاس يحتوي على الثوابت التي تمثل أسماء الشاشات في التطبيق،
/// بالإضافة إلى خريطة (Map) تربط كل اسم شاشة بالويدجت الخاصة بها.
class Routes {
  // تعريف أسماء المسارات كثوابت لتجنب الأخطاء الإملائية
  static const String entry = "/entry";      // شاشة البداية (Splash/Entry)
  static const String login = "/login";      // شاشة تسجيل الدخول
  static const String register = "/register"; // شاشة إنشاء حساب جديد
  static const String home = "/home";        // الشاشة الرئيسية
  static const String about = "/about";      // شاشة "من نحن"

  /// **خريطة المسارات (Routes Map)**
  /// يتم تمرير هذه الخريطة إلى `MaterialApp` لتعريفه بكيفية الانتقال لكل شاشة.
  static Map<String, WidgetBuilder> get routes => {
    entry: (context) => const EntryScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    home: (context) => const HomeScreen(),
    about: (context) => const AboutScreen(),
  };
}
