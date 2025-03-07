import Foundation
import MapboxCoreNavigation
import MapboxDirections
import CoreLocation

class RouteControllerDelegateSpy: RouteControllerDelegate {
    private(set) var recentMessages: [String] = []

    public func reset() {
        recentMessages.removeAll()
    }

    internal func routeController(_ routeController: RouteController, shouldRerouteFrom location: CLLocation) -> Bool {
        recentMessages.append(#function)
        return true
    }

    internal func routeController(_ routeController: RouteController, willRerouteFrom location: CLLocation) {
        recentMessages.append(#function)
    }

    internal func routeController(_ routeController: RouteController, shouldDiscard location: CLLocation) -> Bool {
        recentMessages.append(#function)
        return true
    }
    
    internal func routeController(_ routeController: RouteController, didRerouteAlong route: Route, reason: RouteController.RerouteReason) {
        recentMessages.append(#function)
    }

    internal func routeController(_ routeController: RouteController, didFailToRerouteWith error: Error) {
        recentMessages.append(#function)
    }

    internal func routeController(_ routeController: RouteController, didUpdate locations: [CLLocation]) {
        recentMessages.append(#function)
    }

    internal func routeController(_ routeController: RouteController, didArriveAt waypoint: Waypoint) -> Bool {
        recentMessages.append(#function)
        return true
    }
    
    internal func routeController(_ routeController: RouteController, shouldPreventReroutesWhenArrivingAt waypoint: Waypoint) -> Bool {
        recentMessages.append(#function)
        return true
    }
}
