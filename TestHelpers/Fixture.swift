import Foundation
import MapboxDirections
import MapboxCoreNavigation
import CoreLocation

public class Fixture {
    public class func JSONFromFileNamed<ResponseType: Codable>(
        name: String,
        bundle: Bundle,
        options: RouteOptions,
        credentials: Credentials = .init(accessToken: " "),
        _ type: ResponseType.Type
    ) throws -> ResponseType {
        guard let path = bundle.url(forResource: name, withExtension: "json") ?? bundle.url(forResource: name, withExtension: "geojson") else {
            fatalError("\(name) not found in \(bundle)")
        }

        let decoder = JSONDecoder()
        decoder.userInfo = [
            .options: options,
            .credentials: credentials
        ]
        return try decoder.decode(type, from: try Data(contentsOf: path))
    }

    public class func route(from url: URL) async -> Route {
        let (json, _) = try! await URLSession.shared.data(from: url)
        return route(from: json)
    }

    public class func route(from filename: String, bundle: Bundle,
                            options: RouteOptions,
                            credentials: Credentials = .init(accessToken: " ")) throws -> Route {
        return try Fixture.JSONFromFileNamed(name: filename, bundle: bundle, options: options, credentials: credentials, Route.self)
    }

    fileprivate class func route(from response: Data) -> Route {
        return try! JSONDecoder().decode(Route.self, from: response)
    }

    public class func route(from jsonFile: String, waypoints: [Waypoint], bundle: Bundle,
                            options: RouteOptions,
                            credentials: Credentials = .init(accessToken: " ")) throws -> Route {
        return try JSONFromFileNamed(name: jsonFile, bundle: bundle, options: options, credentials: credentials, Route.self)
    }

    public class func routeWithBannerInstructions(bundle: Bundle) throws -> Route {
        let waypoints = [Waypoint(coordinate: CLLocationCoordinate2D(latitude: 37.795042, longitude: -122.413165)), Waypoint(coordinate: CLLocationCoordinate2D(latitude: 37.7727, longitude: -122.433378))]
        let options = NavigationRouteOptions(waypoints: waypoints)
        return try route(from: "route-with-banner-instructions", waypoints: waypoints, bundle: bundle, options: options)
    }

    public class func blankStyle(bundle: Bundle) -> URL {
        let path = bundle.path(forResource: "EmptyStyle", ofType: "json")
        return URL(fileURLWithPath: path!)
    }

}
