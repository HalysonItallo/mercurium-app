import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercurium_app/app/domain/entities/financial_record_entity.dart';

class FinancialRecordModel implements FinancialRecordEntity {
  FinancialRecordModel({
    this.id,
    required this.value,
    this.createdAt,
    required this.description,
    required this.type,
    required this.category,
    required this.receivedAt,
  });

  FinancialRecordModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"]! as String,
          value: json["value"].toDouble(),
          createdAt: (json['createdAt']! as Timestamp).toDate(),
          description: json["description"]! as String,
          type: json["type"]! as String,
          category: json["category"]! as String,
          receivedAt: (json['receivedAt']! as Timestamp).toDate(),
        );

  @override
  String? id;
  @override
  double value;
  @override
  DateTime? createdAt;
  @override
  String description;
  @override
  String type;
  @override
  String category;
  @override
  DateTime receivedAt;

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "createdAt": createdAt?.toIso8601String(),
        "description": description,
        "type": type,
        "category": category,
        "receivedAt": receivedAt.toIso8601String(),
      };
}
