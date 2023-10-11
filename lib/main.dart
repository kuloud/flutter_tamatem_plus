import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tamatem_plus/api/model/pojos/inventory_item.dart';
import 'package:tamatem_plus/api/model/pojos/user.dart';
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
  late Future<User?> _fetchUser;
  late Future<List<InventoryItem>?> _fetchItems;

  @override
  void initState() {
    super.initState();
    _fetchUser = TamatemPlusPlugin.getUserInfo();
    _fetchItems = TamatemPlusPlugin.fetchInventoryItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                TamatemPlusPlugin.clear();
              },
              icon: const Icon(Icons.delete))
        ],
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
                future: _fetchUser,
                builder: (context, snapshot) {
                  var user = snapshot.data;
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.done:
                      return user != null
                          ? _buildUserInfoCard(user)
                          : const SizedBox.shrink();
                    default:
                      return const SizedBox.shrink();
                  }
                }),
            FutureBuilder(
                future: _fetchItems,
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
                            return _buildInventoryCard(items![index]);
                          });
                    default:
                      return const SizedBox.shrink();
                  }
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.sync),
          onPressed: () {
            logger.d('isConnected: ${TamatemPlusPlugin.isConnected()}');
            _refetchData();
          }),
    );
  }

  void _refetchData() {
    if (TamatemPlusPlugin.isConnected()) {
      setState(() {
        _fetchUser = TamatemPlusPlugin.getUserInfo();
        _fetchItems = TamatemPlusPlugin.fetchInventoryItems();
      });
    }
  }

  Widget _buildUserInfoCard(User user) {
    return Card(
      child: Column(children: [
        ListTile(
          leading: (user.avatar != null)
              ? CircleAvatar(
                  backgroundImage: NetworkImage('${user.avatar}'),
                )
              : null,
          title: Text('ID: ${user.id}'),
          subtitle: Text('Name: ${user.firstName}'),
          trailing: Text('country: ${user.id}'),
        ),
        ListTile(
          title: const Text('gameSavedData'),
          trailing: Text(jsonEncode(user.gameSavedData ?? {})),
        ),
      ]),
    );
  }

  Widget _buildInventoryCard(InventoryItem inventoryItem) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Inventory Item:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text('${inventoryItem.id}\n'),
          Text('Game Player ID: ${inventoryItem.gamePlayerId}'),
          Text('Player Full Name: ${inventoryItem.playerFullName}'),
          Text('Player SerialNumber: ${inventoryItem.playerSerialNumber}'),
          if (inventoryItem.isRedeemed ?? false) const Text('Redeemed'),
          if (inventoryItem.isVerified ?? false) const Text('Verified'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!(inventoryItem.isRedeemed ?? true))
                TextButton(
                    onPressed: () {
                      TamatemPlusPlugin.redeem(inventoryItem.id!,
                              isRedeemed: true)
                          .then((value) => _refetchData());
                    },
                    child: const Text('Redeem')),
              // if (!(inventoryItem.isVerified ?? true))
              //   TextButton(
              //       onPressed: () {
              //         TamatemPlusPlugin.verify(inventoryItem.id!);
              //       },
              //       child: const Text('Verify'))
            ],
          )
        ]),
      ),
    );
  }
}
