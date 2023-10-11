// To parse this JSON data, do
//
//     final inventoryRedeemResponse = inventoryRedeemResponseFromJson(jsonString);

import 'dart:convert';

InventoryRedeemResponse inventoryRedeemResponseFromJson(String str) =>
    InventoryRedeemResponse.fromJson(json.decode(str));

String inventoryRedeemResponseToJson(InventoryRedeemResponse data) =>
    json.encode(data.toJson());

///Request
class InventoryRedeemResponse {
  InventoryRedeemResults? results;
  int? statusCode;
  String? error;
  String? errorDescription;

  InventoryRedeemResponse(
      {this.results, this.statusCode, this.error, this.errorDescription});

  factory InventoryRedeemResponse.fromJson(Map<String, dynamic> json) =>
      InventoryRedeemResponse(
          results: InventoryRedeemResults.fromJson(json["results"]),
          statusCode: json["status_code"],
          error: json["error"],
          errorDescription: json["error_description"]);

  Map<String, dynamic> toJson() => {
        "results": results?.toJson(),
        "status_code": statusCode,
        "error": error,
        "error_description": errorDescription
      };
}

class InventoryRedeemResults {
  bool isRedeemed;
  String verificationToken;

  InventoryRedeemResults({
    required this.isRedeemed,
    required this.verificationToken,
  });

  factory InventoryRedeemResults.fromJson(Map<String, dynamic> json) =>
      InventoryRedeemResults(
        isRedeemed: json["is_redeemed"],
        verificationToken: json["verification_token"],
      );

  Map<String, dynamic> toJson() => {
        "is_redeemed": isRedeemed,
        "verification_token": verificationToken,
      };
}
