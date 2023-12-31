library tamatem_plus;

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamatem_plus/api/model/inventory_item_response.dart';
import 'package:tamatem_plus/api/model/pojos/inventory_item.dart';
import 'package:tamatem_plus/api/model/pojos/user.dart';
import 'package:tamatem_plus/api/tamatem_plus.dart';
import 'package:tamatem_plus/utils/logger.dart';
import 'package:uni_links/uni_links.dart';

class TamatemPlusPlugin {
  static SharedPreferences? _shared;

  static const String kKeyAccessToken = 'tamatem_access_token';
  static const String kKeyUser = 'tamatem_user';

  static TamatemPlus? _tamatemPlus;

  static Future<void> init() async {
    await dotenv.load();
    _tamatemPlus = TamatemPlus(
        dotenv.env['TAMATEM_CLIENT_ID']!, dotenv.env['TAMATEM_CUSTOM_SCHEME']!);
    _shared = await SharedPreferences.getInstance();
    await _initUniLinks();
  }

  static bool isConnected() {
    var accessToken = _shared?.getString(kKeyAccessToken);
    var user = _shared?.getString(kKeyUser);
    return accessToken != null && user != null;
  }

  static void clear() {
    _shared?.remove(TamatemPlusPlugin.kKeyAccessToken);
    _shared?.remove(TamatemPlusPlugin.kKeyUser);
  }

  static Future<User?> getUserInfo() async {
    if (isConnected()) {
      var res = await _tamatemPlus?.getUserInfo();
      if (res?.statusCode != 200) {
        clear();
      }
      return res?.results;
    }
    return null;
  }

  static Future<List<InventoryItem>?> fetchInventoryItems(
      {bool? isRedeemed}) async {
    if (isConnected()) {
      var res = await _tamatemPlus?.getInventoryTtems(isRedeemed);
      return res?.results;
    }
    return null;
  }

  static Future<InventoryRedeemResults?> redeem(String inventoryId,
      {bool? isRedeemed}) async {
    if (isConnected()) {
      var res = await _tamatemPlus?.redeem(inventoryId, isRedeemed: isRedeemed);
      return res?.results;
    }
    return null;
  }

  static Future<User?> verify(String inventoryId) async {
    if (isConnected()) {
      var res = await _tamatemPlus?.verify(inventoryId);
      return res?.results;
    }
    return null;
  }

  static Future<void> _initUniLinks() async {
    try {
      final initialLink = await getInitialLink();
      logger.d('[getInitialLink] > $initialLink');
      if (initialLink != null) {
        _onRedirectToApp(initialLink);
      }
    } on PlatformException {
      // ignore
    }

    linkStream.listen((event) {
      logger.d('[listen] > $event');
      if (event == null) return;
      _onRedirectToApp(event);
    });
  }

  static void _onRedirectToApp(String data) {
    try {
      if (data.startsWith(dotenv.env['TAMATEM_CUSTOM_SCHEME']!)) {
        var uri = Uri.parse(data);
        var code = uri.queryParameters['code'];
        if (isConnected()) {
          _tamatemPlus?.openTamatemPlus();
        } else {
          _tamatemPlus?.getToken(code!).then((res) async {
            if (res?.error == null) {
              //
              var accessToken = res?.results?.accessToken;
              var user = res?.results?.user;
              if (accessToken != null) {
                await _shared?.setString(
                    TamatemPlusPlugin.kKeyAccessToken, accessToken);
                await _shared?.setString(
                    TamatemPlusPlugin.kKeyUser, jsonEncode(user));
              }
              // After calling get-token success, use the SET_PLAYER_ID_ENDPOINT to connect the player to the game
              _tamatemPlus?.setPlayerId('${user!.id}').then((_) {
                _tamatemPlus?.openTamatemPlus();
              }).onError((error, stackTrace) {
                TamatemPlusPlugin.clear();
              });
            }
          }).onError((error, stackTrace) {
            TamatemPlusPlugin.clear();
          });
        }
      }
    } catch (e) {
      // ignore
    }
  }
}
