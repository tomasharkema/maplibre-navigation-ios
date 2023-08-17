import Foundation
import XCTest
import MapboxDirections
@testable import MapboxCoreNavigation
import CoreLocation
import TestHelpers

class RouteProgressTests: XCTestCase {

    var route: Route!

    override func setUp() {
        super.setUp()

        let waypoint1 = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 37.795042, longitude: -122.413165))
        let waypoint2 = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 37.7727, longitude: -122.433378))
        let routeOptions = NavigationRouteOptions(waypoints: [waypoint1, waypoint2])
        let response = try! Fixture.JSONFromFileNamed(name: "routeWithInstructions", bundle: .module, options: routeOptions, RouteResponse.self)
        let directions = Directions(credentials: Credentials(accessToken: "pk.feedCafeDeadBeefBadeBede"))

        route = response.routes!.first!
    }

    func testRouteProgress() {
        let routeProgress = RouteProgress(route: route)
        XCTAssertEqual(routeProgress.fractionTraveled, 0)
        XCTAssertEqual(routeProgress.distanceRemaining, 4316.9)
        XCTAssertEqual(routeProgress.distanceTraveled, 0)
        XCTAssertEqual(round(routeProgress.durationRemaining), 764)
    }
    
    func testRouteLegProgress() {
        let routeProgress = RouteProgress(route: route)
        XCTAssertEqual(routeProgress.currentLeg.description, "Sacramento Street, Gough Street")
        XCTAssertEqual(routeProgress.currentLegProgress.distanceTraveled, 0)
        XCTAssertEqual(round(routeProgress.currentLegProgress.durationRemaining), 764)
        XCTAssertEqual(routeProgress.currentLegProgress.fractionTraveled, 0)
        XCTAssertEqual(routeProgress.currentLegProgress.stepIndex, 0)
        XCTAssertEqual(routeProgress.currentLegProgress.followOnStep?.description, "Turn left onto Gough Street")
        XCTAssertEqual(routeProgress.currentLegProgress.upComingStep?.description, "Turn right onto Sacramento Street")
    }
    
    func testRouteStepProgress() {
        let routeProgress = RouteProgress(route: route)
        XCTAssertEqual(routeProgress.currentLegProgress.currentStepProgress.distanceRemaining, 279.8)
        XCTAssertEqual(routeProgress.currentLegProgress.currentStepProgress.distanceTraveled, 0)
        XCTAssertEqual(routeProgress.currentLegProgress.currentStepProgress.durationRemaining, 79.2)
        XCTAssertEqual(routeProgress.currentLegProgress.currentStepProgress.fractionTraveled, 0)
        XCTAssertEqual(routeProgress.currentLegProgress.currentStepProgress.userDistanceToManeuverLocation, Double.infinity)
        XCTAssertEqual(routeProgress.currentLegProgress.currentStepProgress.step.description, "Head south on Taylor Street")
    }
    
    func testNextRouteStepProgress() {
        let routeProgress = RouteProgress(route: route)
        routeProgress.currentLegProgress.stepIndex = 1
        XCTAssertEqual(routeProgress.currentLegProgress.currentStepProgress.spokenInstructionIndex, 0)
        XCTAssertEqual(routeProgress.currentLegProgress.currentStepProgress.distanceRemaining, 1171)
        XCTAssertEqual(routeProgress.currentLegProgress.currentStepProgress.distanceTraveled, 0)
        XCTAssertEqual(round(routeProgress.currentLegProgress.currentStepProgress.durationRemaining), 194)
        XCTAssertEqual(routeProgress.currentLegProgress.currentStepProgress.fractionTraveled, 0)
        XCTAssertEqual(routeProgress.currentLegProgress.currentStepProgress.userDistanceToManeuverLocation, Double.infinity)
        XCTAssertEqual(routeProgress.currentLegProgress.currentStepProgress.step.description, "Turn right onto Sacramento Street")
    }
}
