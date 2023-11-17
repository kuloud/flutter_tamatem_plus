import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tamatem_plus/api/api.dart';
import 'package:tamatem_plus/api/endpoints.dart';
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

class TamatemPlusApi {
  final Api _api;

  static const String kApiAuthorize = 'o/authorize/';

  static const String _kApiPostGetToken = 'o/get-token/';

  static const String _kApiPostSetPlayerId = 'player/set-player-id/';

  static const String _kApiGetInventoryTtems = 'inventory-item/';

  static const String _kApiGetUserInfo = 'player/';

  static const String _kApiPutRedeemItem = 'inventory/redeem/';

  // ignore: unused_field
  static const String _kApiPutRedeemAll = 'inventory/redeem/';

  static const String _kApiPostLogout = 'player/logout/';

  // ignore: unused_field
  static const String _kApiPutVerify = 'inventory/verify/';

  TamatemPlusApi(this._api);

  Future<GetTokenResponse> getToken(GetTokenRequest request,
      {CancelToken? cancelToken}) async {
    final response = await _api.post('${Endpoints.kCore}$_kApiPostGetToken',
        options: Options(method: 'POST', headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
        }),
        data: request.toJson(),
        cancelToken: cancelToken);
    return getTokenResponseFromJson(jsonEncode(response));
  }

  Future<SetPlayerIdResponse> setPlayerId(SetPlayerIdRequest request,
      {CancelToken? cancelToken}) async {
    final response = await _api.post('${Endpoints.kCore}$_kApiPostSetPlayerId',
        data: request.toJson(), cancelToken: cancelToken);
    return setPlayerIdResponseFromJson(jsonEncode(response));
  }

  Future<GetInventoryItemsResponse> getInventoryItems(
      InventoryItemRequest? request,
      {CancelToken? cancelToken}) async {
    final response = await _api.get('${Endpoints.kCore}$_kApiGetInventoryTtems',
        queryParameters: request?.toJson(), cancelToken: cancelToken);

    return getInventoryItemsResponseFromJson(jsonEncode(response));
  }

  Future<GetUserInfoResponse> getUserInfo(GetUserInfoRequest request,
      {CancelToken? cancelToken}) async {
    final response = await _api.get('${Endpoints.kCore}$_kApiGetUserInfo',
        queryParameters: request.toJson(), cancelToken: cancelToken);
    return getUserInfoResponseFromJson(jsonEncode(response));
  }

  Future<InventoryRedeemResponse> redeem(
      String inventoryId, InventoryItemRequest? request,
      {CancelToken? cancelToken}) async {
    final response = await _api.put(
        '${Endpoints.kCore}$_kApiPutRedeemItem$inventoryId/',
        data: request?.toJson(),
        cancelToken: cancelToken);
    return inventoryRedeemResponseFromJson(jsonEncode(response));
  }

  Future<LogoutResponse> logout() async {
    final response = await _api.post('${Endpoints.kCore}$_kApiPostLogout');
    return logoutResponseFromJson(jsonEncode(response));
  }
}
