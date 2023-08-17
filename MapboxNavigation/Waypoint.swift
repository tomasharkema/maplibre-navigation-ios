import Foundation
import MapboxDirections
import CoreLocation

extension Waypoint {
    var location: CLLocation {
        return CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    var instructionComponent: VisualInstruction.Component? {
        guard let name = name else { return nil }

        return VisualInstruction.Component.text(text: VisualInstruction.Component.TextRepresentation(text: name, abbreviation: nil, abbreviationPriority: nil))
    }
    
    var instructionComponents: [VisualInstruction.Component]? {
        return (instructionComponent != nil) ? [instructionComponent!] : nil
    }
}
