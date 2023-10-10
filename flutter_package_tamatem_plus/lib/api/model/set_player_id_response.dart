// To parse this JSON data, do
//
//     final setPlayerIdRequest = setPlayerIdRequestFromJson(jsonString);

import 'dart:convert';

SetPlayerIdResponse setPlayerIdResponseFromJson(String str) =>
    SetPlayerIdResponse.fromJson(json.decode(str));

String setPlayerIdResponseToJson(SetPlayerIdResponse data) =>
    json.encode(data.toJson());

///Request
class SetPlayerIdResponse {
  String? results;
  int? statusCode;
  String? error;
  String? errorDescription;

  SetPlayerIdResponse(
      {this.results, this.statusCode, this.error, this.errorDescription});

  factory SetPlayerIdResponse.fromJson(Map<String, dynamic> json) =>
      SetPlayerIdResponse(
          results: json["results"],
          statusCode: json["status_code"],
          error: json["error"],
          errorDescription: json["error_description"]);

  Map<String, dynamic> toJson() => {
        "results": results,
        "status_code": statusCode,
        "error": error,
        "error_description": errorDescription
      };
}
