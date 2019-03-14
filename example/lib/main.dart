import 'package:flutter/material.dart';
import 'package:flutter_maps/flutter_maps.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Maps example app'),
        ),
        body: FlutterMap(),
      ),
    );
  }
}
