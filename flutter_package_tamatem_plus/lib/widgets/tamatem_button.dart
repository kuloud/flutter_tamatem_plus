import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamatem_plus/api/model/get_token_response.dart';
import 'package:tamatem_plus/api/tamatem_plus.dart';
import 'package:tamatem_plus/callback/authorize/authorize_code_provider.dart';
import 'package:tamatem_plus/flutter_package_tamatem_plus.dart';
import 'package:tamatem_plus/utils/logger.dart';

class TamatemButton extends StatefulWidget {
  const TamatemButton({super.key, required this.child});

  @override
  State<TamatemButton> createState() => _TamatemButtonState();

  final Widget child;
}

class _TamatemButtonState extends State<TamatemButton> {
  late TamatemPlus tamatemPlus;

  @override
  void initState() {
    super.initState();
    logger.d('TAMATEM_DOMAIN: ${dotenv.env['TAMATEM_DOMAIN']}');
    logger.d('TAMATEM_CLIENT_ID: ${dotenv.env['TAMATEM_CLIENT_ID']}');
    logger.d('TAMATEM_CUSTOM_SCHEME: ${dotenv.env['TAMATEM_CUSTOM_SCHEME']}');
    tamatemPlus = TamatemPlus(
        dotenv.env['TAMATEM_CLIENT_ID']!, dotenv.env['TAMATEM_CUSTOM_SCHEME']!);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TamatemPlusPlugin.getProvider,
      builder: (context, child) {
        return Consumer<AuthorizeCodeProvider>(
            builder: (context, provider, child) {
          final provider = context.read<AuthorizeCodeProvider>();
          final state = provider.state;
          if (state.code != null) {
            try {
              tamatemPlus.getToken(state.code!).then((res) async {
                if (res?.error == null) {
                  //
                  var accessToken = res?.results?.accessToken;
                  var user = res?.results?.user;
                  if (accessToken != null) {
                    var shared = await SharedPreferences.getInstance();
                    await shared.setString('access_token', accessToken);
                    await shared.setString('user', jsonEncode(user));
                  }
                  // After calling get-token success, use the SET_PLAYER_ID_ENDPOINT to connect the player to the game
                  tamatemPlus.setPlayerId('${user!.id}');
                } else {}
              });
            } catch (e) {
              //
            }
          }
          return InkWell(
            onTap: () {
              tamatemPlus.authorize();
            },
            child: Container(
              child: widget.child,
            ),
          );
        });
      },
    );
  }
}
