import Flutter
import UIKit
import MapKit

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
