// To parse this JSON data, do
//
//     final getTokenResponse = getTokenResponseFromJson(jsonString);

import 'dart:convert';

import 'package:tamatem_plus/api/model/pojos/user.dart';

GetUserInfoResponse getUserInfoResponseFromJson(String str) =>
    GetUserInfoResponse.fromJson(json.decode(str));

String getUserInfoResponseToJson(GetUserInfoResponse data) =>
    json.encode(data.toJson());

///Request
class GetUserInfoResponse {
  User? results;
  int? statusCode;
  String? error;
  String? errorDescription;

  GetUserInfoResponse(
      {this.results, this.statusCode, this.error, this.errorDescription});

  factory GetUserInfoResponse.fromJson(Map<String, dynamic> json) =>
      GetUserInfoResponse(
          results: User.fromJson(json["results"]),
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
