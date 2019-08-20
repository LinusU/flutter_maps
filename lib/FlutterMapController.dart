import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_maps/LatLng.dart';

class FlutterMapController {
  MethodChannel _channel;

  FlutterMapController(id) {
    _channel = MethodChannel('com.linusu/flutter_maps_$id');
  }

  Future<bool> zoomTo({LatLng coordinate, double zoomLevel}) async {
    return _channel.invokeMethod(
      'zoomTo',
      <String, double>{
        "lat": coordinate.latitude,
        "lng": coordinate.longitude,
        "zoomLevel": zoomLevel,
      },
    );
  }
}
