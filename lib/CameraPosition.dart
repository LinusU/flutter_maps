import 'package:flutter_maps/LatLng.dart';

class CameraPosition {
  final LatLng coordinate;
  final double zoomLevel;

  CameraPosition({this.coordinate, this.zoomLevel});
}
