import Foundation

class FlutterMapsFactory: NSObject, FlutterPlatformViewFactory {
    var platformView: FlutterMapsView?
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        platformView = FlutterMapsView(frame, viewId: viewId, args: args)
        return platformView!
    }
    
    // Required: otherwise args is nil
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
