import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_maps/LatLng.dart';

class FlutterMapController {
  MethodChannel _channel;

  FlutterMapController(id) {
    _channel = MethodChannel('com.linusu/flutter_maps');
  }

  Future<bool> zoomTo({LatLng coordinate, double zoomLevel}) async {
    var result = await _channel.invokeMethod(
      'zoomTo',
      <String, double>{
        "lat": coordinate.latitude,
        "lng": coordinate.longitude,
        "zoomLevel": zoomLevel,
      },
    );
    return result;
  }
}
