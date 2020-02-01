import XCTest

import FeatureFlagsTests

var tests = [XCTestCaseEntry]()
tests += FeatureFlagsTests.allTests()
XCTMain(tests)
