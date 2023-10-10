// To parse this JSON data, do
//
//     final getTokenResponse = getTokenResponseFromJson(jsonString);

import 'dart:convert';

import 'package:tamatem_plus/api/model/pojos/user.dart';

GetTokenResponse getTokenResponseFromJson(String str) =>
    GetTokenResponse.fromJson(json.decode(str));

String getTokenResponseToJson(GetTokenResponse data) =>
    json.encode(data.toJson());

///Request
class GetTokenResponse {
  GetTokenResults? results;
  int? statusCode;
  String? error;
  String? errorDescription;

  GetTokenResponse(
      {this.results, this.statusCode, this.error, this.errorDescription});

  factory GetTokenResponse.fromJson(Map<String, dynamic> json) =>
      GetTokenResponse(
          results: GetTokenResults.fromJson(json["results"]),
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

class GetTokenResults {
  String accessToken;
  int expiresIn;
  String refreshToken;
  String scope;
  String tokenType;
  User user;

  GetTokenResults({
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
    required this.scope,
    required this.tokenType,
    required this.user,
  });

  factory GetTokenResults.fromJson(Map<String, dynamic> json) =>
      GetTokenResults(
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
        refreshToken: json["refresh_token"],
        scope: json["scope"],
        tokenType: json["token_type"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "expires_in": expiresIn,
        "refresh_token": refreshToken,
        "scope": scope,
        "token_type": tokenType,
        "user": user.toJson(),
      };
}
