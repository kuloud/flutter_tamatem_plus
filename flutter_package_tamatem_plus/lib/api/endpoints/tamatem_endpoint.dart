import 'package:dio/dio.dart';
import 'package:tamatem_plus/api/api.dart';
import 'package:tamatem_plus/api/endpoints.dart';
import 'package:tamatem_plus/api/model/get_token_request.dart';
import 'package:tamatem_plus/api/model/inventory_item_request.dart';
import 'package:tamatem_plus/utils/logger.dart';

class TamatemPlusApi {
  final Api _api;

  static const String kApiAuthorize = 'o/authorize/';

  static const String _kApiPostGetToken = 'o/get-token/';

  static const String _kApiPostSetPlayerId = 'player/set-player-id/';

  static const String _kApiGetInventoryTtems = 'inventory-item';

  static const String _kApiGetUserInfo = '/player/';

  static const String _kApiPutRedeemItem = '/inventory/redeem/';

  static const String _kApiPutRedeemAll = '/inventory/redeem/';

  static const String _kApiPostLogout = '/inventory/redeem/';

  static const String _kApiPutVerify = 'inventory/verify/';

  TamatemPlusApi(this._api);

  Future<void> getToken(GetTokenRequest request,
      {CancelToken? cancelToken}) async {
    final response = await _api.post('${Endpoints.kCore}$_kApiPostGetToken',
        options: Options(method: 'POST', headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
        }),
        data: request.toJson(),
        cancelToken: cancelToken);
    logger.d('---------<> $response');
    // TODO
  }

  Future<void> getInventoryItems(InventoryItemRequest request,
      {CancelToken? cancelToken}) async {
    final response = await _api.get('${Endpoints.kCore}$_kApiGetInventoryTtems',
        options: Options(headers: {
          'Authorization': '',
        }),
        queryParameters: request.toJson(),
        cancelToken: cancelToken);

    // TODO
  }
}
