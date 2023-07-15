// To parse this JSON data, do
//
//     final showMemberModel = showMemberModelFromJson(jsonString);

import 'dart:convert';

ShowMemberModel showMemberModelFromJson(String str) =>
    ShowMemberModel.fromJson(json.decode(str));

String showMemberModelToJson(ShowMemberModel data) =>
    json.encode(data.toJson());

class ShowMemberModel {
  int id;
  int userId;
  String name;
  String address;
  String description;
  dynamic ktp;
  dynamic bankNumber;
  dynamic bankType;
  String memberStatus;
  DateTime createdAt;
  DateTime updatedAt;

  ShowMemberModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.address,
    required this.description,
    this.ktp,
    this.bankNumber,
    this.bankType,
    required this.memberStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShowMemberModel.fromJson(Map<String, dynamic> json) =>
      ShowMemberModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        address: json["address"],
        description: json["description"],
        ktp: json["ktp"],
        bankNumber: json["bank_number"],
        bankType: json["bank_type"],
        memberStatus: json["member_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "address": address,
        "description": description,
        "ktp": ktp,
        "bank_number": bankNumber,
        "bank_type": bankType,
        "member_status": memberStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
