/// **نموذج المعاملة المالية (Transaction Model)**
/// يمثل هذا الكلاس البيانات الخاصة بكل عملية مالية (دخل أو مصروف) يقوم المستخدم بتسجيلها.
class TransactionModel {
  /// المعرّف الفريد للمعاملة (UUID)
  final String id;
  
  /// قيمة المبلغ المالي
  final double amount;
  
  /// تاريخ ووقت تسجيل المعاملة
  final DateTime date;
  
  /// نوع المعاملة: إما 'income' (دخل) أو 'expense' (مصروف)
  final String type; 
  
  /// تصنيف المعاملة (مثل: طعام، مواصلات، راتب...)
  final String category;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  });

  /// -----------------------------------------------------------
  /// **تحويل الكائن (Model) إلى بيانات (Map) للتخزين**
  /// -----------------------------------------------------------
  /// نستخدم هذه الدالة عند إرسال البيانات إلى Firestore، حيث أن قاعدة البيانات
  /// تحتاج البيانات بصيغة JSON (Map).
  /// - نقوم بتحويل التاريخ (`DateTime`) إلى نص (`String`) باستخدام `toIso8601String`.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type,
      'category': category,
    };
  }

  /// -----------------------------------------------------------
  /// **تحويل البيانات القادمة من Firestore إلى كائن (Model)**
  /// -----------------------------------------------------------
  /// نستخدم هذه الدالة عند قراءة البيانات من قاعدة البيانات.
  /// - نقوم بتحويل التاريخ النصي (`String`) القادم من Firebase
  ///   إلى كائن `DateTime` باستخدام `DateTime.parse`.
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      date: DateTime.parse(map['date']),
      type: map['type'] ?? 'expense',
      category: map['category'] ?? 'General',
    );
  }
}
