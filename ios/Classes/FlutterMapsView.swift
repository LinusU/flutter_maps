import Foundation
import MapKit

class FlutterMapsView: NSObject, FlutterPlatformView {
    var mapView: MKMapView?
    
    let frame: CGRect
    let viewId: Int64
    
    init(_ frame: CGRect, viewId: Int64, args: Any?) {
        self.frame = frame
        self.viewId = viewId
        
        mapView = MKMapView(frame: frame)

        let params = args as? [String : Any]
        
        if let initialCameraPosition = params?["initialCameraPosition"] as? [String : Any] {
            let latitude = initialCameraPosition["lat"] as! Double
            let longitude = initialCameraPosition["lng"] as! Double
            var zoomLevel = initialCameraPosition["zoomLevel"] as! Double
            zoomLevel = ZoomLevelConverter.convert(zoomLevel: zoomLevel)
            let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            mapView?.camera = MKMapCamera(lookingAtCenter: center, fromDistance: zoomLevel, pitch: 0.0, heading: 0.0)
        }
    }
    
    func view() -> UIView {
        return mapView!
    }
}
