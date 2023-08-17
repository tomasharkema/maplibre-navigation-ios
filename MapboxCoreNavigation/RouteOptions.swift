import MapboxDirections
import Foundation
import CoreLocation

extension RouteLeg {
    internal var activityType: CLActivityType {
        switch self.profileIdentifier {
        case ProfileIdentifier.cycling, ProfileIdentifier.walking:
            return .fitness
        default:
            return .automotiveNavigation
        }
    }
}

extension RouteOptions {
    internal var activityType: CLActivityType {
        switch self.profileIdentifier {
        case ProfileIdentifier.cycling, ProfileIdentifier.walking:
            return .fitness
        default:
            return .automotiveNavigation
        }
    }
    
    /**
     Returns a copy of RouteOptions without the specified waypoint.
     
     - parameter waypoint: the Waypoint to exclude.
     - returns: a copy of self excluding the specified waypoint.
     */
    public func without(waypoint: Waypoint) -> RouteOptions {
        let waypointsWithoutSpecified = waypoints.filter { $0 != waypoint }
        let copy = self //.copy() as! RouteOptions
        copy.waypoints = waypointsWithoutSpecified
        
        return copy
    }
}
