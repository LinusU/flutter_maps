import Flutter
import UIKit
import MapKit

public class SwiftFlutterMapsPlugin: NSObject, FlutterPlugin {
static var viewFactory: FlutterMapsFactory?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.linusu/flutter_maps", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterMapsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    viewFactory = FlutterMapsFactory()
    registrar.register(viewFactory!, withId: "com.linusu/flutter_maps")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "zoomTo":
        let arguments = call.arguments as? [String : Any]
        let latitude = arguments?["lat"] as! Double
        let longitude = arguments?["lng"] as! Double
        var zoomLevel = arguments?["zoomLevel"] as! Double
        zoomLevel = ZoomLevelConverter.convert(zoomLevel: zoomLevel)
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let camera = MKMapCamera(lookingAtCenter: center, fromDistance: zoomLevel, pitch: 0.0, heading: 0.0)
        SwiftFlutterMapsPlugin.viewFactory?.platformView?.mapView!.setCamera(camera, animated: true)
        result(true)
    default:
        result(false)
    }
  }
}
