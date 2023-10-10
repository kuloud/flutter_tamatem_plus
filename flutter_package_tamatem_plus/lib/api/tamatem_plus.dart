import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamatem_plus/api/api.dart';
import 'package:tamatem_plus/api/endpoints/tamatem_endpoint.dart';
import 'package:tamatem_plus/api/model/authorize_request.dart';
import 'package:tamatem_plus/api/model/get_token_request.dart';
import 'package:tamatem_plus/api/model/get_token_response.dart';
import 'package:tamatem_plus/api/model/inventory_item_request.dart';
import 'package:tamatem_plus/api/model/set_player_id_request.dart';
import 'package:tamatem_plus/api/model/set_player_id_response.dart';
import 'package:tamatem_plus/utils/logger.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'endpoints.dart';

final String kResponseType = 'code';
final String kRedirectUri = 'https://tamatem.co';
final String kCodeChallenge = 'rTFMyKOwuLWO9xZM4mTR6LGiyvDxPGTiRBPY3Hik-fo';
final String kCodeVerifier = 'w-hILxCqImIaKF58kKX985_yQVjXygtmwBpi8lQv9VI';
final String kCodeChallengeMethod = 'S256';
final String kGrantType = 'authorization_code';
final String kScope = 'read write';

/**
 * API Document:
 * https://developers.tamatemplus.com/
 */

class TamatemPlus {
  final String clientId;
  final String redirectUri;

  TamatemPlus(this.clientId, this.redirectUri);

  Future<void> authorize() async {
    var endpointUrl = Uri.parse(
        '${dotenv.env['TAMATEM_DOMAIN']}${Endpoints.kCore}${TamatemPlusApi.kApiAuthorize}');
    var queryParams = AuthorizeRequest(
            clientId: clientId,
            redirectUri: redirectUri,
            codeChallenge: kCodeChallenge,
            codeChallengeMethod: kCodeChallengeMethod,
            responseType: kResponseType)
        .toJson();
    String queryString =
        queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
    var requestUrl = '$endpointUrl?$queryString';
    logger.d(requestUrl.toString());
    launchUrlString(requestUrl, mode: LaunchMode.externalApplication);
  }

  Future<GetTokenResponse?> getToken(String code,
      {CancelToken? cancelToken}) async {
    try {
      final response = await Api.core.getToken(
          GetTokenRequest(
              code: code,
              codeVerifier: kCodeVerifier,
              grantType: kGrantType,
              scope: kScope,
              clientId: clientId,
              redirectUri: redirectUri,
              codeChallengeMethod: kCodeChallengeMethod,
              responseType: kResponseType),
          cancelToken: cancelToken);
      return response;
    } on Exception catch (e) {
      logger.e('[getToken]', error: e);
    }
  }

  Future<SetPlayerIdResponse?> setPlayerId(String playerId,
      {CancelToken? cancelToken}) async {
    try {
      final response = await Api.core.setPlayerId(
          SetPlayerIdRequest(
            playerId: playerId,
          ),
          cancelToken: cancelToken);
      return response;
    } on Exception catch (e) {
      logger.e('[getToken]', error: e);
    }
  }

  Future<void> openTamatemPlus() async {
    var endpointUrl = Uri.parse('${dotenv.env['TAMATEM_GAME_STORE']}');
    launchUrl(endpointUrl);
  }

  Future<void> getInventoryTtems(bool isRedeemed,
      {CancelToken? cancelToken}) async {
    final response = await Api.core.getInventoryItems(
        InventoryItemRequest(isRedeemed: isRedeemed),
        cancelToken: cancelToken);
  }
}
