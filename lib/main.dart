import 'dart:async';

import 'package:flutter/material.dart' hide Intent;
import 'package:receive_intent/receive_intent.dart';

void main() {
  runApp(const MyApp());
}

/// Example app widget for the plugin.
class MyApp extends StatefulWidget {
  /// Constructor of MyApp widget.
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Intent? _initialIntent;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final receivedIntent = await ReceiveIntent.getInitialIntent();

    if (!mounted) return;

    setState(() {
      _initialIntent = receivedIntent;
    });
  }

  Widget _buildFromIntent(String label, Intent intent) {
    return Center(
      child: Column(
        children: [
          Text(label),
          Text(
              'action: ${intent.action}\ndata: ${intent.data}\ncategories: ${intent.categories}'),
          Text("extras: ${intent.extra}")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _initialIntent!.isNull
                  ? Container()
                  : _buildFromIntent("INITIAL", _initialIntent!),
              // StreamBuilder<Intent?>(
              //   stream: ReceiveIntent.receivedIntentStream,
              //   builder: (context, snapshot) => snapshot.data!.isNull
              //       ? Container()
              //       : _buildFromIntent("STREAMED", snapshot.data!),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
