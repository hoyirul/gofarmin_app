// To parse this JSON data, do
//
//     final showGoatModel = showGoatModelFromJson(jsonString);

import 'dart:convert';

ShowGoatModel showGoatModelFromJson(String str) =>
    ShowGoatModel.fromJson(json.decode(str));

String showGoatModelToJson(ShowGoatModel data) => json.encode(data.toJson());

class ShowGoatModel {
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

  ShowGoatModel({
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

  factory ShowGoatModel.fromJson(Map<String, dynamic> json) => ShowGoatModel(
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
