/**
 * Every provider has an explicit priority so they can override each other (e.g. "Remote Config tool" > Store).
 *
 * Not every provider has to provide a flag value for every feature. This is to avoid implicitly relying on build-in
 * defaults (e.g. "Remote Config tool" returns false when no value for a feature) and to avoid that every provider has to provide a
 * value for every feature. (e.g. no "Remote Config tool" configuration needed, unless you want the toggle to be remote)
 */
public protocol FeatureFlagProvider {
    var priority: Priority { get }
    
    func isFeatureEnabled(feature: Feature) -> Bool
    func hasFeature(feature: Feature) -> Bool
}

public protocol RemoteFeatureFlagProvider {
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
