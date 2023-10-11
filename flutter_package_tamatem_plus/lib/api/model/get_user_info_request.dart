// To parse this JSON data, do
//
//     final getUserInfoRequest = getUserInfoFromJson(jsonString);

import 'dart:convert';

GetUserInfoRequest getUserInfoFromJson(String str) =>
    GetUserInfoRequest.fromJson(json.decode(str));

String getUserInfoToJson(GetUserInfoRequest data) => json.encode(data.toJson());

///Request
class GetUserInfoRequest {
  GetUserInfoRequest();

  factory GetUserInfoRequest.fromJson(Map<String, dynamic> json) =>
      GetUserInfoRequest();

  Map<String, dynamic> toJson() => {};
}
