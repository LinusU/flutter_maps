import 'dart:async';

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_maps/CameraPosition.dart';
import 'package:flutter_maps/FlutterMapController.dart';
import 'package:flutter_maps/LatLng.dart';

// class FlutterMaps {
//   static const MethodChannel _channel =
//       const MethodChannel('flutter_maps');

//   static Future<String> get platformVersion async {
//     final String version = await _channel.invokeMethod('getPlatformVersion');
//     return version;
//   }
// }

typedef void FlutterMapCreatedCallback(FlutterMapController controller);

class FlutterMap extends StatefulWidget {
  final FlutterMapCreatedCallback onFlutterMapCreated;
  final CameraPosition initialCameraPosition;

  const FlutterMap({
    Key key,
    this.onFlutterMapCreated,
    this.initialCameraPosition,
  }) : super(key: key);

  @override
  State createState() => _FlutterMapState();
}

class _FlutterMapState extends State<FlutterMap> {

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'com.linusu/flutter_maps',
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: <String, dynamic>{
          "initialCameraPosition": <String, dynamic>{
            "lat": widget.initialCameraPosition.coordinate.latitude,
            "lng": widget.initialCameraPosition.coordinate.longitude,
            "zoomLevel": widget.initialCameraPosition.zoomLevel,
          },
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'com.linusu/flutter_maps',
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: <String, dynamic>{
          "initialCameraPosition": <String, dynamic>{
            "lat": widget.initialCameraPosition.coordinate.latitude,
            "lng": widget.initialCameraPosition.coordinate.longitude,
            "zoomLevel": widget.initialCameraPosition.zoomLevel,
          },
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    }

    return Text('$defaultTargetPlatform is not yet supported by the Flutter Maps plugin');
  }

  Future<void> onPlatformViewCreated(int id) async {
    if (widget.onFlutterMapCreated == null) {
      return;
    }
    widget.onFlutterMapCreated(FlutterMapController(id));
  }
}
