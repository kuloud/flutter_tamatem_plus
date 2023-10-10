// To parse this JSON data, do
//
//     final getInventoryItemsResponse = getInventoryItemsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:tamatem_plus/api/model/pojos/inventory_item.dart';

GetInventoryItemsResponse getInventoryItemsResponseFromJson(String str) =>
    GetInventoryItemsResponse.fromJson(json.decode(str));

String getInventoryItemsResponseToJson(GetInventoryItemsResponse data) =>
    json.encode(data.toJson());

///Request
class GetInventoryItemsResponse {
  List<InventoryItem> results;
  int statusCode;

  GetInventoryItemsResponse({
    required this.results,
    required this.statusCode,
  });

  factory GetInventoryItemsResponse.fromJson(Map<String, dynamic> json) =>
      GetInventoryItemsResponse(
        results: List<InventoryItem>.from(
            json["results"].map((x) => InventoryItem.fromJson(x))),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "status_code": statusCode,
      };
}
