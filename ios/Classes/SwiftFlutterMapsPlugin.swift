import Flutter
import UIKit
import MapKit

class FlutterMapsFactory: NSObject, FlutterPlatformViewFactory {
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FlutterMapsView(frame, viewId: viewId, args: args)
    }
}

class FlutterMapsView: NSObject, FlutterPlatformView {
    let frame: CGRect
    let viewId: Int64

    init(_ frame: CGRect, viewId: Int64, args: Any?) {
        self.frame = frame
        self.viewId = viewId
    }

    func view() -> UIView {
        return MKMapView(frame: frame)
    }
}

public class SwiftFlutterMapsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_maps", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterMapsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    let viewFactory = FlutterMapsFactory()
    registrar.register(viewFactory, withId: "com.linusu/flutter_maps")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
