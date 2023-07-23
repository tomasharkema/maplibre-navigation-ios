import Foundation
import XCTest

//@objc(MBFixture)
//public class Fixture: NSObject {
//    @objc class func stringFromFileNamed(name: String) -> String {
//        guard let path = Bundle.module.path(forResource: name, ofType: "json") ?? Bundle(for: self).path(forResource: name, ofType: "geojson") else {
//            XCTAssert(false, "Fixture \(name) not found.")
//            return ""
//        }
//        do {
//            return try String(contentsOfFile: path, encoding: .utf8)
//        } catch {
//            XCTAssert(false, "Unable to decode fixture at \(path): \(error).")
//            return ""
//        }
//    }
//    
//    @objc class func JSONFromFileNamed(name: String) -> [String: Any] {
//        let bundle = Bundle.module
//        guard let path = bundle.path(forResource: name, ofType: "json") ?? Bundle(for: self).path(forResource: name, ofType: "geojson") else {
//            XCTAssert(false, "Fixture \(name) not found.")
//            return [:]
//        }
//        guard let data = NSData(contentsOfFile: path) else {
//            XCTAssert(false, "No data found at \(path).")
//            return [:]
//        }
//        do {
//            return try JSONSerialization.jsonObject(with: data as Data, options: []) as! [String: AnyObject]
//        } catch {
//            XCTAssert(false, "Unable to decode JSON fixture at \(path): \(error).")
//            return [:]
//        }
//    }
//}
