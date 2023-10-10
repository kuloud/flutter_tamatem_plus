// To parse this JSON data, do
//
//     final inventoryItemRequest = inventoryItemFromJson(jsonString);

import 'dart:convert';

InventoryItemRequest inventoryItemFromJson(String str) =>
    InventoryItemRequest.fromJson(json.decode(str));

String inventoryItemToJson(InventoryItemRequest data) =>
    json.encode(data.toJson());

///Request
class InventoryItemRequest {
  bool isRedeemed;

  InventoryItemRequest({
    required this.isRedeemed,
  });

  factory InventoryItemRequest.fromJson(Map<String, dynamic> json) =>
      InventoryItemRequest(
        isRedeemed: json["is_redeemed"],
      );

  Map<String, dynamic> toJson() => {
        "is_redeemed": isRedeemed,
      };
}
