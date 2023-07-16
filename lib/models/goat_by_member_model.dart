// To parse this JSON data, do
//
//     final goatByMemberModel = goatByMemberModelFromJson(jsonString);

import 'dart:convert';

List<GoatByMemberModel> goatByMemberModelFromJson(String str) =>
    List<GoatByMemberModel>.from(
        json.decode(str).map((x) => GoatByMemberModel.fromJson(x)));

String goatByMemberModelToJson(List<GoatByMemberModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GoatByMemberModel {
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

  GoatByMemberModel({
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

  factory GoatByMemberModel.fromJson(Map<String, dynamic> json) =>
      GoatByMemberModel(
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
