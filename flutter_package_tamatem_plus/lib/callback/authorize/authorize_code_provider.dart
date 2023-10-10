import 'package:flutter/material.dart';
import 'package:tamatem_plus/callback/authorize/authorize_code_state.dart';

class AuthorizeCodeProvider extends ChangeNotifier {
  final state = AuthorizeCodeState();

  void onRedirectToApp(String code) {
    var uri = Uri.parse(code);
    state.code = uri.queryParameters['code'];
    notifyListeners();
  }
}
