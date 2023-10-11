// To parse this JSON data, do
//
//     final getTokenResponse = getTokenResponseFromJson(jsonString);

import 'dart:convert';

LogoutResponse logoutResponseFromJson(String str) =>
    LogoutResponse.fromJson(json.decode(str));

String logoutResponseToJson(LogoutResponse data) => json.encode(data.toJson());

///Request
class LogoutResponse {
  dynamic results;
  int? statusCode;
  String? error;
  String? errorDescription;

  LogoutResponse(
      {this.results, this.statusCode, this.error, this.errorDescription});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
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
