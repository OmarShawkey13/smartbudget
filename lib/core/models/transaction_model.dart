class TransactionModel {
  final String id;
  final double amount;
  final DateTime date;
  final String type; // 'income' or 'expense'
  final String category;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type,
      'category': category,
    };
  }

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
