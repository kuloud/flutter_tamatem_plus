import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tamatem_plus/callback/authorize/authorize_code_state.dart';

class AuthorizeCodeProvider extends ChangeNotifier {
  final state = AuthorizeCodeState();

  void onRedirectToApp(String code) {
    if (code.startsWith(dotenv.env['TAMATEM_CUSTOM_SCHEME']!)) {
      var uri = Uri.parse(code);
      state.code = uri.queryParameters['code'];
      notifyListeners();
    }
  }
}
