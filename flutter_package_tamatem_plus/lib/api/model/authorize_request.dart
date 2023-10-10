// To parse this JSON data, do
//
//     final authorizeRequest = authorizeRequestFromJson(jsonString);

import 'dart:convert';

AuthorizeRequest authorizeRequestFromJson(String str) =>
    AuthorizeRequest.fromJson(json.decode(str));

String authorizeRequestToJson(AuthorizeRequest data) =>
    json.encode(data.toJson());

///Request
class AuthorizeRequest {
  String clientId;
  String codeChallenge;
  String codeChallengeMethod;
  String redirectUri;
  String responseType;

  AuthorizeRequest({
    required this.clientId,
    required this.codeChallenge,
    required this.codeChallengeMethod,
    required this.redirectUri,
    required this.responseType,
  });

  factory AuthorizeRequest.fromJson(Map<String, dynamic> json) =>
      AuthorizeRequest(
        clientId: json["client_id"],
        codeChallenge: json["code_challenge"],
        codeChallengeMethod: json["code_challenge_method"],
        redirectUri: json["redirect_uri"],
        responseType: json["response_type"],
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "code_challenge": codeChallenge,
        "code_challenge_method": codeChallengeMethod,
        "redirect_uri": redirectUri,
        "response_type": responseType,
      };
}
