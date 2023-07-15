// To parse this JSON data, do
//
//     final portofolioModel = portofolioModelFromJson(jsonString);

import 'dart:convert';

PortofolioModel portofolioModelFromJson(String str) =>
    PortofolioModel.fromJson(json.decode(str));

String portofolioModelToJson(PortofolioModel data) =>
    json.encode(data.toJson());

class PortofolioModel {
  int id;
  int uInvestorId;
  int portofolio;
  DateTime createdAt;
  DateTime updatedAt;

  PortofolioModel({
    required this.id,
    required this.uInvestorId,
    required this.portofolio,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PortofolioModel.fromJson(Map<String, dynamic> json) =>
      PortofolioModel(
        id: json["id"],
        uInvestorId: json["u_investor_id"],
        portofolio: json["portofolio"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "u_investor_id": uInvestorId,
        "portofolio": portofolio,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
