library tamatem_plus;

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamatem_plus/api/model/pojos/inventory_item.dart';
import 'package:tamatem_plus/api/tamatem_plus.dart';
import 'package:tamatem_plus/callback/authorize/authorize_code_provider.dart';
import 'package:tamatem_plus/utils/logger.dart';
import 'package:uni_links/uni_links.dart';

class TamatemPlusPlugin {
  static final AuthorizeCodeProvider _provider = AuthorizeCodeProvider();
  static AuthorizeCodeProvider get getProvider => _provider;
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
    logger.d('ssss, ${accessToken}');
    return accessToken != null && user != null;
  }

  static void clear() async {
    var shared = await SharedPreferences.getInstance();
    await shared.remove(TamatemPlusPlugin.kKeyAccessToken);
    await shared.remove(TamatemPlusPlugin.kKeyUser);
  }

  static Future<List<InventoryItem>?> fetchInventoryItems() async {
    if (isConnected()) {
      var res = await _tamatemPlus?.getInventoryTtems(true);
      if (res?.statusCode != null) {
        clear();
      }
      return res?.results;
    }
  }

  static Future<void> _initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      logger.d('[getInitialLink] > $initialLink');
      if (initialLink != null) {
        _provider.onRedirectToApp(initialLink);
      }
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }

    linkStream.listen((event) {
      logger.d('[listen] > $event');
      if (event == null) return;
      _provider.onRedirectToApp(event);
    });
  }
}
