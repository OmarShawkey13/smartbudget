import 'package:smartbudget/core/utils/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// **Service Locator (sl)**
/// هو الكائن المسؤول عن الوصول لجميع التبعيات (Dependencies) المحقونة في التطبيق.
/// بنستخدمه عشان نستدعي أي كلاس مسجل جواه من أي مكان في الكود.
final sl = GetIt.instance;

/// **دالة تهيئة الحقن (Dependency Injection Initialization)**
/// يتم استدعاء هذه الدالة في `main.dart` قبل تشغيل التطبيق لضمان جاهزية جميع الكلاسات.
Future<void> initInjections() async {
  
  /// -------------------------------------------------------------------
  /// **1. تسجيل الـ Cubits / Blocs**
  /// -------------------------------------------------------------------
  /// نستخدم `registerFactory` مع الـ Cubit لأننا نحتاج إنشاء نسخة جديدة (New Instance)
  /// في كل مرة يتم طلبه فيها. هذا يضمن أن الحالة (State) تبدأ نظيفة عند فتح الشاشة
  /// ويتم إغلاقها بشكل صحيح عند الخروج (dispose).
  sl.registerFactory(() => HomeCubit());

  /// -------------------------------------------------------------------
  /// **2. تسجيل التبعيات الخارجية (External Dependencies)**
  /// -------------------------------------------------------------------
  
  // ننتظر حتى يتم تحميل SharedPreferences لأنه عملية Future
  final sharedPref = await SharedPreferences.getInstance();

  /// نستخدم `registerLazySingleton` للأشياء التي نريد منها نسخة واحدة فقط (Singleton)
  /// تظل موجودة طوال دورة حياة التطبيق (مثل التخزين المحلي، اتصالات الشبكة).
  /// كلمة `Lazy` تعني أنه لن يتم إنشاؤه إلا عند طلبه لأول مرة لتوفير الموارد.
  sl.registerLazySingleton(() => sharedPref);
}
