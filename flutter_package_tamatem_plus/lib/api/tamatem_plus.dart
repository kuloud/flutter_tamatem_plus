import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tamatem_plus/api/api.dart';
import 'package:tamatem_plus/api/endpoints/tamatem_endpoint.dart';
import 'package:tamatem_plus/api/model/authorize_request.dart';
import 'package:tamatem_plus/api/model/get_inventory_items_response.dart';
import 'package:tamatem_plus/api/model/get_token_request.dart';
import 'package:tamatem_plus/api/model/get_token_response.dart';
import 'package:tamatem_plus/api/model/get_user_info_request.dart';
import 'package:tamatem_plus/api/model/get_user_info_response.dart';
import 'package:tamatem_plus/api/model/inventory_item_request.dart';
import 'package:tamatem_plus/api/model/inventory_item_response.dart';
import 'package:tamatem_plus/api/model/logout_response.dart';
import 'package:tamatem_plus/api/model/set_player_id_request.dart';
import 'package:tamatem_plus/api/model/set_player_id_response.dart';
import 'package:tamatem_plus/utils/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'endpoints.dart';

const String kResponseType = 'code';
const String kCodeChallenge = 'rTFMyKOwuLWO9xZM4mTR6LGiyvDxPGTiRBPY3Hik-fo';
const String kCodeVerifier = 'w-hILxCqImIaKF58kKX985_yQVjXygtmwBpi8lQv9VI';
const String kCodeChallengeMethod = 'S256';
const String kGrantType = 'authorization_code';
const String kScope = 'read write';

/// API Document:
/// https://developers.tamatemplus.com/

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
    return null;
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
      logger.e('[setPlayerId]', error: e);
    }
    return null;
  }

  Future<void> openTamatemPlus() async {
    var endpointUrl = Uri.parse('${dotenv.env['TAMATEM_GAME_STORE']}');
    launchUrl(endpointUrl);
  }

  Future<GetInventoryItemsResponse?> getInventoryTtems(bool? isRedeemed,
      {CancelToken? cancelToken}) async {
    try {
      final response = await Api.core.getInventoryItems(
          isRedeemed != null
              ? InventoryItemRequest(isRedeemed: isRedeemed)
              : null, // without 'isRedeemed' to get all
          cancelToken: cancelToken);
      return response;
    } on Exception catch (e) {
      logger.e('[getInventoryTtems]', error: e);
    }
    return null;
  }

  Future<GetUserInfoResponse?> getUserInfo({CancelToken? cancelToken}) async {
    try {
      final response = await Api.core
          .getUserInfo(GetUserInfoRequest(), cancelToken: cancelToken);
      return response;
    } on Exception catch (e) {
      logger.e('[getUserInfo]', error: e);
    } catch (e) {
      logger.e('[getUserInfo]', error: e);
    }
    return null;
  }

  Future<InventoryRedeemResponse?> redeem(String inventoryId,
      {CancelToken? cancelToken, bool? isRedeemed}) async {
    try {
      final response = await Api.core.redeem(
          inventoryId,
          isRedeemed != null
              ? InventoryItemRequest(isRedeemed: isRedeemed)
              : null,
          cancelToken: cancelToken);
      return response;
    } on Exception catch (e) {
      logger.e('[redeem]', error: e);
    } catch (e) {
      logger.e('[redeem]', error: e);
    }
    return null;
  }

  /// TODO
  Future<GetUserInfoResponse?> verify(String inventoryId,
      {CancelToken? cancelToken, bool? isVerified}) async {
    // try {
    //   final response = await Api.core.redeem(
    //       inventoryId,
    //       isVerified != null
    //           ? InventoryItemRequest(isRedeemed: isVerified)
    //           : null,
    //       cancelToken: cancelToken);
    //   return response;
    // } on Exception catch (e) {
    //   logger.e('[verify]', error: e);
    // } catch (e) {
    //   logger.e('[verify]', error: e);
    // }
    return null;
  }

  Future<LogoutResponse?> logout() async {
    try {
      final response = await Api.core.logout();
      return response;
    } on Exception catch (e) {
      logger.e('[logout]', error: e);
    }
    return null;
  }
}
