import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tamatem_plus/api/tamatem_plus.dart';
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
  void dispose() {
    super.dispose();
    if (TamatemPlusPlugin.isConnected()) {
      TamatemPlusPlugin.fetchInventoryItems(isRedeemed: false).then((items) {
        if ((items?.length ?? 0) == 0) {
          tamatemPlus.logout();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        tamatemPlus.authorize();
      },
      child: Container(
        child: widget.child,
      ),
    );
  }
}
