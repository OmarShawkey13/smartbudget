import 'package:flutter/material.dart';

/// **إضافات السياق (Context Extensions)**
/// هذا الملف يحتوي على Extension Methods يتم إضافتها على `BuildContext`
/// لتسهيل كتابة أكواد التنقل (Navigation) وجعلها أنظف وأقصر.
extension NavigationExtension on BuildContext {
  
  /// -----------------------------------------------------------
  /// **الانتقال إلى شاشة جديدة (Push)**
  /// -----------------------------------------------------------
  /// بدلاً من كتابة `Navigator.pushNamed(context, ...)`،
  /// يمكننا الآن كتابة `context.push(...)` مباشرة.
  /// - `routeName`: اسم المسار المراد الانتقال إليه (من ملف Routes).
  /// - `arguments`: أي بيانات إضافية نريد تمريرها للشاشة الجديدة (اختياري).
  void push<ARG>(String routeName, {ARG? arguments}) =>
      Navigator.pushNamed(this, routeName, arguments: arguments);

  /// -----------------------------------------------------------
  /// **استبدال الشاشة الحالية بشاشة جديدة (Push Replacement)**
  /// -----------------------------------------------------------
  /// تستخدم عندما لا نريد السماح للمستخدم بالعودة للشاشة السابقة (مثل الانتقال من Login إلى Home).
  /// بدلاً من `Navigator.pushReplacementNamed(context, ...)`،
  /// نستخدم `context.pushReplacement(...)`.
  void pushReplacement<ARG>(String routeName, {ARG? arguments}) =>
      Navigator.pushReplacementNamed(this, routeName, arguments: arguments);

  /// -----------------------------------------------------------
  /// **العودة للشاشة السابقة (Pop)**
  /// -----------------------------------------------------------
  /// لإغلاق الشاشة الحالية والعودة للخلف.
  /// بدلاً من `Navigator.pop(context)`، يمكننا كتابة `context.pop`.
  void get pop => Navigator.maybePop(this);

  /// -----------------------------------------------------------
  /// **استخراج البيانات الممررة (Get Arguments)**
  /// -----------------------------------------------------------
  /// دالة مساعدة للحصول على الـ arguments الممررة للشاشة الحالية بطريقة آمنة (Type-Safe).
  /// - تقوم بإرجاع البيانات إذا كانت من النوع المتوقع `ARG`، وإلا ترجع `null`.
  ARG? getArg<ARG>() {
    final args = ModalRoute.of(this)?.settings.arguments;
    if (args is ARG) {
      return args;
    }
    return null;
  }
}
