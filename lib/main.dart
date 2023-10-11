import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tamatem_plus/api/model/pojos/inventory_item.dart';
import 'package:tamatem_plus/flutter_package_tamatem_plus.dart';
import 'package:tamatem_plus/utils/logger.dart';
import 'package:tamatem_plus/widgets/tamatem_button.dart';

void main() async {
  await TamatemPlusPlugin.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<InventoryItem>?> _fetch;

  @override
  void initState() {
    super.initState();
    _fetch = TamatemPlusPlugin.fetchInventoryItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const TamatemButton(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Launch tamatem',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            ),
            FutureBuilder(
                future: _fetch,
                builder: (context, snapshot) {
                  var items = snapshot.data;
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    case ConnectionState.done:
                      return ListView.builder(
                          padding: const EdgeInsets.all(8),
                          shrinkWrap: true,
                          itemCount: items?.length ?? 0,
                          itemBuilder: (context, index) {
                            return _buildCard(items![index]);
                          });
                    default:
                      return const SizedBox.shrink();
                  }
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            logger.d('isConnected: ${TamatemPlusPlugin.isConnected()}');
            if (TamatemPlusPlugin.isConnected()) {
              setState(() {
                _fetch = TamatemPlusPlugin.fetchInventoryItems();
              });
            }
          }),
    );
  }

  Widget _buildCard(InventoryItem inventoryItem) {
    return Card(
      child: Column(children: [
        ListTile(
          title: const Text('id'),
          trailing: Text(inventoryItem.id ?? ''),
        ),
        ListTile(
          title: const Text('name'),
          trailing: Text(inventoryItem.name ?? ''),
        ),
        ListTile(
          title: const Text('player_full_name'),
          trailing: Text(inventoryItem.playerFullName ?? ''),
        ),
        ListTile(
          title: const Text('player_serial_number'),
          trailing: Text(inventoryItem.playerSerialNumber ?? ''),
        ),
        ListTile(
          title: const Text('game_player_id'),
          trailing: Text(inventoryItem.gamePlayerId ?? ''),
        ),
        ListTile(
          title: const Text('is_redeemed'),
          trailing: Text('${inventoryItem.isRedeemed}'),
        ),
        ListTile(
          title: const Text('is_verified'),
          trailing: Text('${inventoryItem.isVerified}'),
        ),
      ]),
    );
  }
}
