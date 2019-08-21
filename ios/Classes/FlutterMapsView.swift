import Foundation
import MapKit

class FlutterMapsView: NSObject, FlutterPlatformView {
    let frame: CGRect
    let viewId: Int64
    
    var methodChannel: FlutterMethodChannel?
    
    var initialCameraPosition: MKMapCamera? = nil
    
    init(_ frame: CGRect, viewId: Int64, args: Any?) {
        self.frame = frame
        self.viewId = viewId

        let params = args as? [String : Any]
        
        if let initialCameraPosition = params?["initialCameraPosition"] as? [String : Any] {
            let latitude = initialCameraPosition["lat"] as! Double
            let longitude = initialCameraPosition["lng"] as! Double
            let zoomLevel = initialCameraPosition["zoomLevel"] as! Double
            let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            self.initialCameraPosition = MKMapCamera(lookingAtCenter: center, fromDistance: zoomLevel, pitch: 0.0, heading: 0.0)
        }
    }
    
    func view() -> UIView {
        let mapView = MKMapView(frame: frame)
        
        if let initialCameraPosition = self.initialCameraPosition {
            mapView.camera = initialCameraPosition
        }
        
        return mapView
    }
}
