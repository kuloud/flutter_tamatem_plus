import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:tamatem_plus/api/tamatem_plus.dart';
import 'package:tamatem_plus/callback/authorize/authorize_code_provider.dart';
import 'package:tamatem_plus/flutter_package_tamatem_plus.dart';
import 'package:tamatem_plus/utils/logger.dart';

class TamatemButton extends StatefulWidget {
  const TamatemButton({super.key});

  @override
  State<TamatemButton> createState() => _TamatemButtonState();
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
            //
            logger.d('->>>>${state.code}');
            try {
              tamatemPlus.getToken(state.code!);
            } catch (e) {
              //
            }
          }
          return IconButton(
              onPressed: () {
                tamatemPlus.authorize();
              },
              icon: const Icon(Icons.comment));
        });
      },
    );
  }

  Future<void> login() async {
    try {
      var credentials = await tamatemPlus.authorize();
      // logger.d(jsonEncode(credentials));

      setState(() {
        // _user = credentials.user;
      });
    } catch (e) {
      logger.w(e);
    }
  }

  Future<void> logout() async {
    try {
      // await auth0
      //     .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
      //     .logout();
      setState(() {
        // _user = null;
      });
    } catch (e) {
      logger.w(e);
    }
  }
}
