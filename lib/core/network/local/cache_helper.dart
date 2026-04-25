import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartbudget/core/di/injections.dart';

/// **مساعد التخزين المحلي (Cache Helper)**
/// هذا الكلاس مسؤول عن التعامل مع `SharedPreferences` لحفظ واسترجاع البيانات البسيطة
/// محلياً على الجهاز، مثل إعدادات المستخدم (الثيم، اللغة، حالة تسجيل الدخول).
class CacheHelper {
  
  /// -----------------------------------------------------------
  /// **استرجاع البيانات (Get Data)**
  /// -----------------------------------------------------------
  /// تستخدم هذه الدالة لقراءة قيمة مخزنة سابقاً باستخدام المفتاح (Key).
  /// - `key`: اسم المفتاح الذي تم حفظ البيانات به.
  /// - نستخدم `sl<SharedPreferences>()` للحصول على النسخة المحقونة (Dependency Injection).
  static dynamic getData({required String key}) {
    final prefs = sl<SharedPreferences>();
    return prefs.get(key);
  }

  /// -----------------------------------------------------------
  /// **حفظ البيانات (Save Data)**
  /// -----------------------------------------------------------
  /// تستخدم هذه الدالة لحفظ قيمة جديدة أو تحديث قيمة موجودة.
  /// تقوم الدالة تلقائياً بتحديد نوع البيانات (String, int, bool, double, List<String>)
  /// واستدعاء دالة الحفظ المناسبة من `SharedPreferences`.
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    final prefs = sl<SharedPreferences>();

    if (value is String) return await prefs.setString(key, value);
    if (value is int) return await prefs.setInt(key, value);
    if (value is bool) return await prefs.setBool(key, value);
    if (value is double) return await prefs.setDouble(key, value);
    if (value is List<String>) return await prefs.setStringList(key, value);

    // في حالة تمرير نوع بيانات غير مدعوم
    throw ArgumentError(
      'Unsupported type for SharedPreferences: ${value.runtimeType}',
    );
  }

  /// -----------------------------------------------------------
  /// **حذف البيانات (Remove Data)**
  /// -----------------------------------------------------------
  /// تستخدم هذه الدالة لحذف قيمة مخزنة نهائياً باستخدام مفتاحها.
  /// مفيدة عند تسجيل الخروج (Logout) لمسح التوكن أو البيانات المؤقتة.
  static Future<bool> removeData({required String key}) async {
    final prefs = sl<SharedPreferences>();
    return await prefs.remove(key);
  }
}
