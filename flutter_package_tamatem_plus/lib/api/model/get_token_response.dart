// To parse this JSON data, do
//
//     final getTokenResponse = getTokenResponseFromJson(jsonString);

import 'dart:convert';

GetTokenResponse getTokenResponseFromJson(String str) =>
    GetTokenResponse.fromJson(json.decode(str));

String getTokenResponseToJson(GetTokenResponse data) =>
    json.encode(data.toJson());

///Request
class GetTokenResponse {
  String clientId;
  String codeChallenge;
  String codeChallengeMethod;
  String redirectUri;
  String responseType;
  Results results;
  int statusCode;

  GetTokenResponse({
    required this.clientId,
    required this.codeChallenge,
    required this.codeChallengeMethod,
    required this.redirectUri,
    required this.responseType,
    required this.results,
    required this.statusCode,
  });

  factory GetTokenResponse.fromJson(Map<String, dynamic> json) =>
      GetTokenResponse(
        clientId: json["client_id"],
        codeChallenge: json["code_challenge"],
        codeChallengeMethod: json["code_challenge_method"],
        redirectUri: json["redirect_uri"],
        responseType: json["response_type"],
        results: Results.fromJson(json["results"]),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "code_challenge": codeChallenge,
        "code_challenge_method": codeChallengeMethod,
        "redirect_uri": redirectUri,
        "response_type": responseType,
        "results": results.toJson(),
        "status_code": statusCode,
      };
}

class Results {
  String accessToken;
  int expiresIn;
  String refreshToken;
  String scope;
  String tokenType;
  User user;

  Results({
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
    required this.scope,
    required this.tokenType,
    required this.user,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
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

class User {
  dynamic avatar;
  String country;
  String dateOfBirth;
  String firstName;
  GameSavedData gameSavedData;
  String gender;
  int id;
  String lastName;
  String qrCode;
  String signUpThrough;
  String tamatemId;

  User({
    required this.avatar,
    required this.country,
    required this.dateOfBirth,
    required this.firstName,
    required this.gameSavedData,
    required this.gender,
    required this.id,
    required this.lastName,
    required this.qrCode,
    required this.signUpThrough,
    required this.tamatemId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: json["avatar"],
        country: json["country"],
        dateOfBirth: json["date_of_birth"],
        firstName: json["first_name"],
        gameSavedData: GameSavedData.fromJson(json["game_saved_data"]),
        gender: json["gender"],
        id: json["id"],
        lastName: json["last_name"],
        qrCode: json["qr_code"],
        signUpThrough: json["sign_up_through"],
        tamatemId: json["tamatem_id"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "country": country,
        "date_of_birth": dateOfBirth,
        "first_name": firstName,
        "game_saved_data": gameSavedData.toJson(),
        "gender": gender,
        "id": id,
        "last_name": lastName,
        "qr_code": qrCode,
        "sign_up_through": signUpThrough,
        "tamatem_id": tamatemId,
      };
}

class GameSavedData {
  String exampleKey;
  String exampleKey1;
  String exampleKey2;

  GameSavedData({
    required this.exampleKey,
    required this.exampleKey1,
    required this.exampleKey2,
  });

  factory GameSavedData.fromJson(Map<String, dynamic> json) => GameSavedData(
        exampleKey: json["exampleKey..."],
        exampleKey1: json["exampleKey1"],
        exampleKey2: json["exampleKey2"],
      );

  Map<String, dynamic> toJson() => {
        "exampleKey...": exampleKey,
        "exampleKey1": exampleKey1,
        "exampleKey2": exampleKey2,
      };
}
