//
//  Route.swift
//  MapboxCoreNavigation
//
//  Created by Sander van Tulden on 28/10/2022.
//  Copyright © 2022 Mapbox. All rights reserved.
//
import MapboxDirections
import CoreLocation
import MapboxCoreNavigation
import MapboxCoreNavigationObjC
import TestHelpers

extension Route {
    convenience init(jsonFileName: String, waypoints: [CLLocationCoordinate2D], polylineShapeFormat: RouteShapeFormat = .polyline6, bundle: Bundle = .main, accessToken: String) {
        let convertedWaypoints = waypoints.compactMap { waypoint in
            Waypoint(coordinate: waypoint)
        }
        let routeOptions = NavigationRouteOptions(waypoints: convertedWaypoints)
        routeOptions.shapeFormat = polylineShapeFormat
        self.init(jsonFileName: jsonFileName, waypoints: waypoints, accessToken: accessToken)
    }
}
