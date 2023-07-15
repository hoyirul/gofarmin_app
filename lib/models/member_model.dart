// To parse this JSON data, do
//
//     final memberModel = memberModelFromJson(jsonString);

import 'dart:convert';

List<MemberModel> memberModelFromJson(String str) => List<MemberModel>.from(
    json.decode(str).map((x) => MemberModel.fromJson(x)));

String memberModelToJson(List<MemberModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberModel {
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

  MemberModel({
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

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
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
