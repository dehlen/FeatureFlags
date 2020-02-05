import XCTest
@testable import FeatureFlags

class FeatureFlagsTestCase: XCTestCase {
    var runtimeBehavior: RuntimeBehavior!
    
    override func setUp() {
        super.setUp()
        runtimeBehavior = RuntimeBehavior(providers: [])
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_IsFeatureEnabled() {
        // default value is false
        XCTAssertFalse(runtimeBehavior.isFeatureEnabled(feature: DisabledMockFeature()))
        
        // default value is true
        XCTAssertTrue(runtimeBehavior.isFeatureEnabled(feature: EnabledMockFeature()))
        
        runtimeBehavior.addProvider(provider: MockFeatureFlagProvider())
        
        // provider returns false
        XCTAssertFalse(runtimeBehavior.isFeatureEnabled(feature: DisabledMockFeature()))
        
        // provider returns true
        XCTAssertTrue(runtimeBehavior.isFeatureEnabled(feature: EnabledMockFeature()))
    }
    
    func test_RefreshFeatureFlags() {
        let remoteProvider = MockRemoteFeatureFlagProvider()
        XCTAssertFalse(remoteProvider.didCallRefresh)
        runtimeBehavior.addProvider(provider: remoteProvider)
        runtimeBehavior.refreshFeatureFlags()
        XCTAssertTrue(remoteProvider.didCallRefresh)
    }
    
    func test_AddProvider() {
        XCTAssertEqual(runtimeBehavior.providers.count, 0)
        runtimeBehavior.addProvider(provider: MockFeatureFlagProvider())
        XCTAssertEqual(runtimeBehavior.providers.count, 1)
        runtimeBehavior.addProvider(provider: MockRemoteFeatureFlagProvider())
        XCTAssertEqual(runtimeBehavior.providers.count, 2)
    }
    
    func test_ClearFeatureFlagProviders() {
        XCTAssertEqual(runtimeBehavior.providers.count, 0)
        runtimeBehavior.addProvider(provider: MockFeatureFlagProvider())
        XCTAssertEqual(runtimeBehavior.providers.count, 1)
        runtimeBehavior.clearFeatureFlagProviders()
        XCTAssertEqual(runtimeBehavior.providers.count, 0)
    }
    
    func test_RemoveAllFeatureFlagProviders() {
        XCTAssertEqual(runtimeBehavior.providers.count, 0)
        runtimeBehavior.addProvider(provider: MockFeatureFlagProvider())
        XCTAssertEqual(runtimeBehavior.providers.count, 1)
        runtimeBehavior.addProvider(provider: MockRemoteFeatureFlagProvider())
        XCTAssertEqual(runtimeBehavior.providers.count, 2)
        runtimeBehavior.removeAllFeatureFlagProviders(priority: .min)
        XCTAssertEqual(runtimeBehavior.providers.count, 1)
        runtimeBehavior.removeAllFeatureFlagProviders(priority: .medium)
        XCTAssertEqual(runtimeBehavior.providers.count, 0)
    }
}

class DisabledMockFeature: Feature {
    var key: String = "key"
    var title: String = "title"
    var explanation: String = "explanation"
    var defaultValue: Bool = false
}

class EnabledMockFeature: Feature {
    var key: String = "key"
    var title: String = "title"
    var explanation: String = "explanation"
    var defaultValue: Bool = true
}

class MockFeatureFlagProvider: FeatureFlagProvider {
    var priority: Priority = .min
    
    func isFeatureEnabled(feature: Feature) -> Bool {
        return feature.defaultValue
    }

    func hasFeature(feature: Feature) -> Bool {
        return true
    }
}

class MockRemoteFeatureFlagProvider: FeatureFlagProvider, RemoteFeatureFlagProvider {
    var priority: Priority = .medium
    var didCallRefresh: Bool = false
       
    func isFeatureEnabled(feature: Feature) -> Bool {
        return feature.defaultValue
    }
    
    func hasFeature(feature: Feature) -> Bool {
        return true
    }
    
    func refreshFeatureFlags() {
        didCallRefresh = true
    }
}
