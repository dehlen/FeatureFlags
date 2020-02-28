import XCTest
import FeatureFlags

var tests = [XCTestCaseEntry]()
tests += FeatureFlags.allTests()
XCTMain(tests)
