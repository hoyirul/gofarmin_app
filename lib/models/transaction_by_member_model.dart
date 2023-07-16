// To parse this JSON data, do
//
//     final transactionByMemberModel = transactionByMemberModelFromJson(jsonString);

import 'dart:convert';

List<TransactionByMemberModel> transactionByMemberModelFromJson(String str) =>
    List<TransactionByMemberModel>.from(
        json.decode(str).map((x) => TransactionByMemberModel.fromJson(x)));

String transactionByMemberModelToJson(List<TransactionByMemberModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionByMemberModel {
  String name;
  String goatName;
  int qty;
  int price;
  int total;
  String status;
  String type;
  DateTime createdAt;

  TransactionByMemberModel({
    required this.name,
    required this.goatName,
    required this.qty,
    required this.price,
    required this.total,
    required this.status,
    required this.type,
    required this.createdAt,
  });

  factory TransactionByMemberModel.fromJson(Map<String, dynamic> json) =>
      TransactionByMemberModel(
        name: json["name"],
        goatName: json["goat_name"],
        qty: json["qty"],
        price: json["price"],
        total: json["total"],
        status: json["status"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "goat_name": goatName,
        "qty": qty,
        "price": price,
        "total": total,
        "status": status,
        "type": type,
        "created_at": createdAt.toIso8601String(),
      };
}
