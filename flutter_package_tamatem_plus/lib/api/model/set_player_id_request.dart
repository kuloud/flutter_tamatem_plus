// To parse this JSON data, do
//
//     final setPlayerIdRequest = setPlayerIdRequestFromJson(jsonString);

import 'dart:convert';

SetPlayerIdRequest setPlayerIdRequestFromJson(String str) =>
    SetPlayerIdRequest.fromJson(json.decode(str));

String setPlayerIdRequestToJson(SetPlayerIdRequest data) =>
    json.encode(data.toJson());

///Request
class SetPlayerIdRequest {
  String playerId;

  SetPlayerIdRequest({
    required this.playerId,
  });

  factory SetPlayerIdRequest.fromJson(Map<String, dynamic> json) =>
      SetPlayerIdRequest(
        playerId: json["player_id"],
      );

  Map<String, dynamic> toJson() => {
        "player_id": playerId,
      };
}
