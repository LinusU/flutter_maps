import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_maps/flutter_maps.dart';
import 'package:flutter_maps/FlutterMapController.dart';
import 'package:flutter_maps/LatLng.dart';
import 'package:flutter_maps/CameraPosition.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterMapController _controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      _controller.zoomTo(
        coordinate: LatLng(
          latitude: 51.5006,
          longitude: -0.1253,
        ),
        zoomLevel: 12.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Maps example app'),
        ),
        body: FlutterMap(
          initialCameraPosition: CameraPosition(
            coordinate: LatLng(
              latitude: 50.8442,
              longitude: 4.3533,
            ),
            zoomLevel: 17.0,
          ),
          onFlutterMapCreated: (FlutterMapController controller) {
            _controller = controller;
          },
        ),
      ),
    );
  }
}
