import Foundation

public class RuntimeFeatureFlagProvider: FeatureFlagProvider {
    private let preferences: UserDefaults
    public var priority: Priority = .medium

    public init(preferences: UserDefaults = UserDefaults.standard) {
        self.preferences = preferences
    }

    public func isFeatureEnabled(feature: Feature) -> Bool {
        if preferences.contains(key: feature.key) {
            return preferences.bool(forKey: feature.key)
        }
        
        return feature.defaultValue
    }

    public func hasFeature(feature: Feature) -> Bool {
        return true
    }

    public func setFeatureEnabled(feature: Feature, enabled: Bool) {
        preferences.set(enabled, forKey: feature.key)
    }
}

extension UserDefaults {
    func contains(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
