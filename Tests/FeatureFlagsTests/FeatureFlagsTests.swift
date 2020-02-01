import XCTest
@testable import FeatureFlags

final class FeatureFlagsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FeatureFlags().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
