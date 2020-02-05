import Foundation

/// Implements a FeatureFlagProvider which stores the feature flag in UserDefaults.
public class RuntimeFeatureFlagProvider: FeatureFlagProvider {
    private let preferences: UserDefaults
    
    /// The priority of the provider.
    public var priority: Priority

    /// Init the provider with a given UserDefaults and priority.
    /// Defaults to `UserDefaults.standard` and `Priority.medium`
    public init(preferences: UserDefaults = UserDefaults.standard, priority: Priority = .medium) {
        self.preferences = preferences
        self.priority = priority
    }

    /// Returns whether a given feature is enabled or not from the context of the provider.
    /// If the feature with its key is found in the provided UserDefaults, the stored value is returned else the features default value.
    ///
    /// - Parameter feature: The feature to inspect.
    /// - Returns: A bool representing whether the feature is enabled or not.
    public func isFeatureEnabled(feature: Feature) -> Bool {
        if preferences.contains(key: feature.key) {
            return preferences.bool(forKey: feature.key)
        }
        
        return feature.defaultValue
    }
    
    /// Returns whether a given feature is handled by the provider or not.
    ///
    /// - Parameter feature: The feature to inspect.
    /// - Returns: A bool representing whether the feature is handled or not.
    public func hasFeature(feature: Feature) -> Bool {
        return true
    }

    /// Sets the enabled state for a given feature by storing a key/value pair in the UserDefaults.
    ///
    /// - Parameter feature: The feature for which the enabled state should be mutated.
    /// - Parameter enabled: Whether the feature should be enabled or not.
    public func setFeatureEnabled(feature: Feature, enabled: Bool) {
        preferences.set(enabled, forKey: feature.key)
    }
}

extension UserDefaults {
    func contains(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
