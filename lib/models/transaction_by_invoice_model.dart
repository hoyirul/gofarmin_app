// To parse this JSON data, do
//
//     final transactionByInvoiceModel = transactionByInvoiceModelFromJson(jsonString);

import 'dart:convert';

TransactionByInvoiceModel transactionByInvoiceModelFromJson(String str) =>
    TransactionByInvoiceModel.fromJson(json.decode(str));

String transactionByInvoiceModelToJson(TransactionByInvoiceModel data) =>
    json.encode(data.toJson());

class TransactionByInvoiceModel {
  int id;
  int uInvestorId;
  int goatId;
  String invoice;
  int qty;
  int price;
  int total;
  String pop;
  String status;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  Goat goat;

  TransactionByInvoiceModel({
    required this.id,
    required this.uInvestorId,
    required this.goatId,
    required this.invoice,
    required this.qty,
    required this.price,
    required this.total,
    required this.pop,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.goat,
  });

  factory TransactionByInvoiceModel.fromJson(Map<String, dynamic> json) =>
      TransactionByInvoiceModel(
        id: json["id"],
        uInvestorId: json["u_investor_id"],
        goatId: json["goat_id"],
        invoice: json["invoice"],
        qty: json["qty"],
        price: json["price"],
        total: json["total"],
        pop: json["pop"],
        status: json["status"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        goat: Goat.fromJson(json["goat"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "u_investor_id": uInvestorId,
        "goat_id": goatId,
        "invoice": invoice,
        "qty": qty,
        "price": price,
        "total": total,
        "pop": pop,
        "status": status,
        "type": type,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "goat": goat.toJson(),
      };
}

class Goat {
  int id;
  int uMemberId;
  String goatName;
  int age;
  int price;
  String information;
  String category;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  Goat({
    required this.id,
    required this.uMemberId,
    required this.goatName,
    required this.age,
    required this.price,
    required this.information,
    required this.category,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Goat.fromJson(Map<String, dynamic> json) => Goat(
        id: json["id"],
        uMemberId: json["u_member_id"],
        goatName: json["goat_name"],
        age: json["age"],
        price: json["price"],
        information: json["information"],
        category: json["category"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "u_member_id": uMemberId,
        "goat_name": goatName,
        "age": age,
        "price": price,
        "information": information,
        "category": category,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
