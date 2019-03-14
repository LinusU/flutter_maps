import 'dart:async';

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';

// class FlutterMaps {
//   static const MethodChannel _channel =
//       const MethodChannel('flutter_maps');

//   static Future<String> get platformVersion async {
//     final String version = await _channel.invokeMethod('getPlatformVersion');
//     return version;
//   }
// }

class FlutterMap extends StatefulWidget {
  const FlutterMap();

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
        // gestureRecognizers: widget.gestureRecognizers,
        // creationParams: creationParams,
        // creationParamsCodec: const StandardMessageCodec(),
      );
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'com.linusu/flutter_maps',
        onPlatformViewCreated: onPlatformViewCreated,
      );
    }

    return Text('$defaultTargetPlatform is not yet supported by the Flutter Maps plugin');
  }

  Future<void> onPlatformViewCreated(int id) async {
    debugPrint("VIEW CREATED");
  }
}
