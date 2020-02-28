import Foundation

/// The repository caching all the available feature flags
public protocol FeatureToggleRepository {
    /// retrieves a stored `FeatureToggleRepresentable` from the underlying store.
    func retrieve(identifiable: FeatureToggleIdentifiable) -> FeatureToggleRepresentable
    /// saves a supplied `FeatureToggleRepresentable` to the underlying store
    func save(featureToggle: FeatureToggleRepresentable)
}

/// Concrete implementation of a FeatureFlagRepository. Stores the feature flags in the UserDefaults.
public class FeatureToggleUserDefaultsRepository {
    private static let defaultsSuiteName = "featureToggleUserDefaultsRepositorySuite"
    private let defaults: UserDefaults
    
    /// Initialize the repository with some given UserDefaults. If nil a UserDefaults suite is created for you. If creation of the suite fails fallsback to `UserDefaults.standard`
    public init(defaults: UserDefaults? = nil) {
        self.defaults = defaults ?? UserDefaults(suiteName: FeatureToggleUserDefaultsRepository.defaultsSuiteName) ?? .standard
    }
}

extension FeatureToggleUserDefaultsRepository: FeatureToggleRepository {
    /** Retrieve a feature flag from the repository
    *  @param identifiable The identifier of the feature flag
    **/
    public func retrieve(identifiable: FeatureToggleIdentifiable) -> FeatureToggleRepresentable {
        let isActive = defaults.value(forKey: identifiable.identifier) as? Bool
        
        return FeatureToggle(identifier: identifiable.identifier, isActive: isActive ?? identifiable.fallbackValue)
    }
    
    /** Save a feature flag to the repository
    *  @param featureToggle The feature flag to save
    **/
    public func save(featureToggle: FeatureToggleRepresentable) {
        defaults.set(featureToggle.isActive, forKey: featureToggle.identifier)
    }
}
