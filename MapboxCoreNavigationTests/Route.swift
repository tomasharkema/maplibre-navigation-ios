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
    convenience init(jsonFileName: String, waypoints: [CLLocationCoordinate2D], polylineShapeFormat: RouteShapeFormat = .polyline6, bundle: Bundle = .main, accessToken: String) throws {
        let convertedWaypoints = waypoints.compactMap { waypoint in
            Waypoint(coordinate: waypoint)
        }
        let routeOptions = NavigationRouteOptions(waypoints: convertedWaypoints)
        routeOptions.shapeFormat = polylineShapeFormat
//        self = try Fixture.JSONFromFileNamed(name: jsonFileName, bundle: bundle, options: routeOptions, Route.self)!
        let route = try Fixture.JSONFromFileNamed(name: jsonFileName, bundle: bundle, options: routeOptions, Route.self)
        self.init(legs: route.legs, shape: route.shape, distance: route.distance, expectedTravelTime: route.expectedTravelTime)
    }
}
