/// **نموذج بيانات المستخدم (User Model)**
/// يمثل هذا الكلاس البيانات الأساسية للمستخدم التي سيتم تخزينها في قاعدة البيانات (Firestore).
class UserModel {
  /// المعرّف الفريد للمستخدم (من Firebase Auth)
  final String? uid;
  
  /// البريد الإلكتروني للمستخدم
  final String? email;
  
  /// اسم المستخدم (للعرض في التطبيق)
  final String? username;

  const UserModel({
    required this.uid,
    required this.email,
    required this.username,
  });

  /// -----------------------------------------------------------
  /// **تحويل البيانات القادمة من Firestore إلى كائن (Model)**
  /// -----------------------------------------------------------
  /// نستخدم هذه الدالة عند قراءة البيانات من قاعدة البيانات (Map)
  /// وتحويلها إلى كائن `UserModel` يسهل التعامل معه داخل التطبيق.
  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      email: map['email'] ?? '',
      username: map['username'] ?? '',
    );
  }

  /// -----------------------------------------------------------
  /// **تحويل الكائن (Model) إلى بيانات (Map) للتخزين**
  /// -----------------------------------------------------------
  /// نستخدم هذه الدالة عند إرسال البيانات إلى Firestore، حيث أن قاعدة البيانات
  /// تتعامل مع صيغة `Map<String, dynamic>` (JSON-like structure).
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
    };
  }
}
