// To parse this JSON data, do
//
//     final getInventoryItemsResponse = getInventoryItemsResponseFromJson(jsonString);

import 'dart:convert';

GetInventoryItemsResponse getInventoryItemsResponseFromJson(String str) =>
    GetInventoryItemsResponse.fromJson(json.decode(str));

String getInventoryItemsResponseToJson(GetInventoryItemsResponse data) =>
    json.encode(data.toJson());

///Request
class GetInventoryItemsResponse {
  List<Result> results;
  int statusCode;

  GetInventoryItemsResponse({
    required this.results,
    required this.statusCode,
  });

  factory GetInventoryItemsResponse.fromJson(Map<String, dynamic> json) =>
      GetInventoryItemsResponse(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "status_code": statusCode,
      };
}

class Result {
  String? codeValue;
  String? gamePlayerId;
  String? id;
  bool? isRedeemed;
  bool? isVerified;
  String? name;
  String? playerFullName;
  String? playerSerialNumber;

  Result({
    this.codeValue,
    this.gamePlayerId,
    this.id,
    this.isRedeemed,
    this.isVerified,
    this.name,
    this.playerFullName,
    this.playerSerialNumber,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        codeValue: json["code_value"],
        gamePlayerId: json["game_player_id"],
        id: json["id"],
        isRedeemed: json["is_redeemed"],
        isVerified: json["is_verified"],
        name: json["name"],
        playerFullName: json["player_full_name"],
        playerSerialNumber: json["player_serial_number"],
      );

  Map<String, dynamic> toJson() => {
        "code_value": codeValue,
        "game_player_id": gamePlayerId,
        "id": id,
        "is_redeemed": isRedeemed,
        "is_verified": isVerified,
        "name": name,
        "player_full_name": playerFullName,
        "player_serial_number": playerSerialNumber,
      };
}
