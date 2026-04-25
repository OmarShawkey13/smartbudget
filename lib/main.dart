import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbudget/core/di/injections.dart';
import 'package:smartbudget/core/network/local/cache_helper.dart';
import 'package:smartbudget/core/theme/theme.dart';
import 'package:smartbudget/core/utils/constants/my_bloc_observer.dart';
import 'package:smartbudget/core/utils/constants/routes.dart';
import 'package:smartbudget/core/utils/cubit/home_cubit.dart';
import 'package:smartbudget/core/utils/cubit/home_state.dart';
import 'package:smartbudget/firebase_options.dart';

/// **مفتاح التنقل العالمي (Navigator Key)**
/// نستخدم هذا المفتاح للوصول إلى الـ Context من أي مكان في التطبيق (حتى خارج الـ Widgets).
/// مفيد جداً في حالات مثل إظهار Dialogs من داخل الـ Bloc أو التعامل مع الإشعارات.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// **نقطة البداية (Main Function)**
/// هي أول دالة يتم تنفيذها عند تشغيل التطبيق.
Future<void> main() async {
  // ضمان تهيئة Flutter Engine قبل تنفيذ أي كود يعتمد على الـ Native (مثل Firebase).
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة حقن التبعيات (Service Locator) لتجهيز الكلاسات والخدمات.
  await initInjections();

  // تهيئة Firebase لربط التطبيق بمشروع Firebase الخاص بك.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // تعيين مراقب للـ Bloc (BlocObserver) لمراقبة التغييرات في الحالة وطباعتها في الـ Console (للتطوير).
  Bloc.observer = MyBlocObserver();

  // قراءة حالة الثيم (Dark/Light) المحفوظة محلياً لضبطها عند بدء التشغيل.
  final bool isDark = CacheHelper.getData(key: 'isDark') ?? false;

  // تشغيل التطبيق (الروت Widget).
  runApp(MyApp(isDark: isDark));
}

/// **تطبيق الروت (Root Widget)**
/// هذا الكلاس يمثل جذر شجرة الـ Widgets في التطبيق.
class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    // نستخدم BlocProvider لإنشاء وتوفير HomeCubit على مستوى التطبيق بالكامل.
    // ..changeTheme(fromShared: isDark) -> لضبط الثيم المفضل للمستخدم فور الإنشاء.
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..changeTheme(fromShared: isDark),
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          // MaterialApp: الويدجت الأساسية التي توفر تصميم Material وإعدادات التوجيه والثيم.
          return MaterialApp(
            // إخفاء شريط "Debug" من الزاوية العلوية.
            debugShowCheckedModeBanner: false,

            // ربط مفتاح التنقل العالمي.
            navigatorKey: navigatorKey,

            // تعريف خريطة المسارات (Routes) للتنقل بين الشاشات.
            routes: Routes.routes,

            // تحديد أول شاشة تظهر عند الفتح (Splash/Entry).
            initialRoute: Routes.entry,

            // تعريف الثيم الفاتح (Light Theme).
            theme: AppTheme.lightTheme,

            // تعريف الثيم الداكن (Dark Theme).
            darkTheme: AppTheme.darkTheme,

            // تحديد وضع الثيم الحالي بناءً على قيمة المتغير في HomeCubit.
            themeMode: HomeCubit.get(context).isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
          );
        },
      ),
    );
  }
}
