// To parse this JSON data, do
//
//     final getTokenRequest = getTokenRequestFromJson(jsonString);

import 'dart:convert';

GetTokenRequest getTokenRequestFromJson(String str) =>
    GetTokenRequest.fromJson(json.decode(str));

String getTokenRequestToJson(GetTokenRequest data) =>
    json.encode(data.toJson());

///Request
class GetTokenRequest {
  String code;
  String codeVerifier;
  String grantType;
  String scope;
  String clientId;
  String codeChallengeMethod;
  String redirectUri;
  String responseType;

  GetTokenRequest({
    required this.code,
    required this.codeVerifier,
    required this.grantType,
    required this.scope,
    required this.clientId,
    required this.codeChallengeMethod,
    required this.redirectUri,
    required this.responseType,
  });

  factory GetTokenRequest.fromJson(Map<String, dynamic> json) =>
      GetTokenRequest(
        code: json["code"],
        codeVerifier: json["code_verifier"],
        grantType: json["grant_type"],
        scope: json["scope"],
        clientId: json["client_id"],
        codeChallengeMethod: json["code_challenge_method"],
        redirectUri: json["redirect_uri"],
        responseType: json["response_type"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "code_verifier": codeVerifier,
        "grant_type": grantType,
        "scope": scope,
        "client_id": clientId,
        "code_challenge_method": codeChallengeMethod,
        "redirect_uri": redirectUri,
        "response_type": responseType,
      };
}
