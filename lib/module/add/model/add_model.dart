import 'package:flutter_calculator/utils/extantion/enum.dart';

class TransactionEntry {
  final int? id;
  final TransactionType type;
  final DateTime date;
  final String name;
  final double amount;
  final String phoneNumber;
  final String familyEvent; // Changed to String
  final String relationship; // Changed to String
  final String? note;
  final String? memo;
  final DateTime createdAt;
  final DateTime? updatedAt;

  TransactionEntry({
    this.id,
    required this.type,
    required this.date,
    required this.name,
    required this.amount,
    required this.phoneNumber,
    required this.familyEvent, // Make familyEvent required
    required this.relationship, // Make relationship required
    this.note,
    this.memo,
    required this.createdAt,
    this.updatedAt,
  });

  // Factory method for converting JSON to a TransactionEntry instance
  factory TransactionEntry.fromJson(Map<String, dynamic> json) {
    return TransactionEntry(
      id: json['id'] as int?,
      type: TransactionType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => TransactionType.SPENT_MONEY, // Provide a fallback value
      ),
      date: DateTime.parse(json['date'] as String),
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      phoneNumber: json['phoneNumber'] as String,
      familyEvent: json['familyEvent'] as String? ??
          (throw Exception(
              "familyEvent is required")), // Ensure it's a required string
      relationship: json['relationship'] as String? ??
          (throw Exception(
              "relationship is required")), // Ensure it's a required string
      note: json['note'] as String?,
      memo: json['memo'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  // Method for converting a TransactionEntry instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'date': date.toIso8601String(),
      'name': name,
      'amount': amount,
      'phoneNumber': phoneNumber,
      'familyEvent': familyEvent, // No need to convert, it's already a String
      'relationship': relationship, // No need to convert, it's already a String
      'note': note,
      'memo': memo,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
