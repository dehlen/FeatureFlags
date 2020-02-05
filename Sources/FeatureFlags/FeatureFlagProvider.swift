/// Every provider has an explicit priority so they can override each other (e.g. "Remote Config tool" > Store).
/// Not every provider has to provide a flag value for every feature. This is to avoid implicitly relying on built-in defaults (e.g. "Remote Config tool" returns false when no value for a feature) and to avoid that every provider has to provide a value for every feature. (e.g. no "Remote Config tool" configuration needed, unless you want the toggle to be remote)
///
public protocol FeatureFlagProvider {
    /// The priority of the provider. 0 = highest priority, 3 = minimum priority
    var priority: Priority { get }
    
    /// Returns whether a given feature is enabled or not from the context of the provider.
    ///
    /// - Parameter feature: The feature to inspect.
    /// - Returns: A bool representing whether the feature is enabled or not.
    func isFeatureEnabled(feature: Feature) -> Bool
    
    /// Returns whether a given feature is handled by the provider or not.
    ///
    /// - Parameter feature: The feature to inspect.
    /// - Returns: A bool representing whether the feature is handled or not.
    func hasFeature(feature: Feature) -> Bool
}

public protocol RemoteFeatureFlagProvider {
    /// Is triggered when the remote feature flags should be refreshed.
    func refreshFeatureFlags()
}

public enum Priority: Int, Comparable {
    case test = 0
    case max = 1
    case medium = 2
    case min = 3
    
    public static func < (lhs: Priority, rhs: Priority) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
