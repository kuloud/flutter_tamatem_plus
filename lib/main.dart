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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const TamatemButton(
              child: Text(
                'Launch tamatem',
                style: TextStyle(color: Colors.red),
              ),
            ),
            FutureBuilder(
                future: _fetch,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var items = snapshot.data;
                    return ListView.builder(itemBuilder: (context, index) {
                      return _buildCard(items![index]);
                    });
                  } else {
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
    return Text(inventoryItem.name ?? '');
  }
}
