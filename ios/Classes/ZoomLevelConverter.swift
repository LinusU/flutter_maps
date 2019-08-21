import Foundation

class ZoomLevelConverter {
    
    /// Converts a zoomLevel to an altitude in meters
    ///
    /// - Parameter zoomLevel: the zoomLevel to convert to meters
    /// - Returns: the altitude in meters
    static func convert(zoomLevel: Double) -> Double {
        
        var zoomMeters: Double = 53523872.0
        
        for _ in 1..<Int(zoomLevel) {
            zoomMeters = zoomMeters / 2
        }

        return zoomMeters
    }
}
