import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartbudget/core/utils/constants/routes.dart';
import 'package:smartbudget/core/utils/extensions/context_extension.dart';

/// **شاشة الدخول (Entry Screen)**
/// هي أول شاشة تظهر عند فتح التطبيق (تعمل كـ Splash Screen).
/// وظيفتها الأساسية هي تحديد وجهة المستخدم:
/// - إذا كان مسجلاً للدخول -> يذهب للرئيسية (Home).
/// - إذا لم يكن مسجلاً -> يذهب لتسجيل الدخول (Login).
class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  void initState() {
    super.initState();
    // ننتظر حتى يتم بناء الواجهة (Build) لأول مرة، ثم ننفذ دالة التوجيه.
    // هذا ضروري لأننا لا نستطيع استخدام `context` للانتقال أثناء عملية الـ build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _routeUser();
    });
  }

  /// **دالة توجيه المستخدم (_routeUser)**
  /// تقوم بفحص حالة المصادقة (Auth State) وتوجيه المستخدم.
  Future<void> _routeUser() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    // 1. إذا لم يكن هناك مستخدم مسجل حالياً
    if (user == null) {
      // نذهب لشاشة تسجيل الدخول ونمسح شاشة الـ Entry من المكدس (Stack)
      context.pushReplacement<Object>(Routes.login);
      return;
    }

    // 2. إذا كان هناك مستخدم، نقوم بدخول سريع للرئيسية (لتحسين تجربة المستخدم)
    context.pushReplacement<Object>(Routes.home);

    // 3. تحقق في الخلفية (Background Check)
    // نحاول تحديث بيانات المستخدم للتأكد من أن الحساب لا يزال صالحاً (غير محذوف أو معطل).
    try {
      await user.reload();
    } catch (_) {
      // إذا فشل التحديث (مثلاً الحساب محذوف من لوحة التحكم)، نقوم بتسجيل الخروج
      await auth.signOut();
      // وإذا كانت الشاشة لا تزال معروضة (أو التطبيق مفتوح)، نعود لشاشة تسجيل الدخول
      if (mounted) {
        context.pushReplacement<Object>(Routes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // نعرض مؤشر تحميل بسيط أثناء عملية الفحص
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
