import 'package:dio/dio.dart';
import 'package:tamatem_plus/api/api.dart';
import 'package:tamatem_plus/api/endpoints.dart';
import 'package:tamatem_plus/api/model/get_token_request.dart';
import 'package:tamatem_plus/api/model/inventory_item_request.dart';
import 'package:tamatem_plus/utils/logger.dart';

class TamatemPlusApi {
  final Api _api;

  static const String kApiAuthorize = '/o/authorize';

  static const String _kApiGetToken = '/o/get-token';

  static const String _kApiInventoryTtems = '/inventory/list';

  static const String _kApiSetGameData = '/player/set-game-data';

  static const String _kApiPlayer = '/player';

  static const String _kApiRedeem = '/inventory/redeem';

  TamatemPlusApi(this._api);

  Future<void> getToken(GetTokenRequest request,
      {CancelToken? cancelToken}) async {
    final response = await _api.get('${Endpoints.kCore}$_kApiGetToken',
        options: Options(headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
        }),
        // queryParameters: request.toJson(),
        data: request.toJson(),
        cancelToken: cancelToken);
    logger.d('---------<> $response');
    // TODO
  }

  Future<void> getInventoryItems(InventoryItemRequest request,
      {CancelToken? cancelToken}) async {
    final response = await _api.get('${Endpoints.kCore}$_kApiInventoryTtems',
        options: Options(headers: {
          'Authorization': '',
        }),
        queryParameters: request.toJson(),
        cancelToken: cancelToken);

    // TODO
  }
}
