library tamatem_plus;

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uni_links/uni_links.dart';

import 'callback/authorize/authorize_code_provider.dart';
import 'utils/logger.dart';

class TamatemPlusPlugin {
  static final AuthorizeCodeProvider _provider = AuthorizeCodeProvider();
  static AuthorizeCodeProvider get getProvider => _provider;

  static Future<void> init() async {
    await dotenv.load();
    await initUniLinks();
  }

  void connect() {}

  static Future<void> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      logger.d('------->>>>$initialLink');
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
      logger.d('-listen------>>>>$event');
      if (event == null) return;
      _provider.onRedirectToApp(event);
    });
  }
}
