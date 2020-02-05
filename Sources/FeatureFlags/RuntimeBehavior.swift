/// Check whether a feature should be enabled or not. Based on the priority of the different providers and if said provider explicitly defines a value for that feature, the value of the flag is returned.
public class RuntimeBehavior {
    
    /// The registered providers
    private(set) public var providers = [FeatureFlagProvider]()

    /// Init with a given set of providers.
    public init(providers: [FeatureFlagProvider]) {
        self.providers = providers
    }

    /// Returns whether a given feature is enabled or not from the context of the provider.
    /// The first provider with the highest priority which handles the given feature returns the value else the features default value is returned.
    ///
    /// - Parameter feature: The feature to inspect.
    /// - Returns: A bool representing whether the feature is enabled or not.
    public func isFeatureEnabled(feature: Feature) -> Bool {
        guard let provider = providers
            .filter({ $0.hasFeature(feature: feature) })
            .sorted(by: \.priority)
            .first else {
            return feature.defaultValue
        }
        return provider.isFeatureEnabled(feature: feature)
    }

    /// For every registered provider refreshFeatureFlags() is called
    public func refreshFeatureFlags() {
        providers
            .compactMap { $0 as? RemoteFeatureFlagProvider }
            .forEach { $0.refreshFeatureFlags() }
    }

    /// Registers the given provider.
    ///
    /// - Parameter provider: The provider to register.
    public func addProvider(provider: FeatureFlagProvider) {
        providers.append(provider)
    }

    /// Removes all registered providers.
    public func clearFeatureFlagProviders() {
        providers.removeAll()
    }

    /// Removes all registered providers with the given priority.
    ///
    /// - Parameter priority: The priority for which providers should be removed.
    public func removeAllFeatureFlagProviders(priority: Priority) {
        providers.removeAll(where: {
            $0.priority == priority
        })
    }
}

extension Collection {
    /// Returns Array<Element> sorted by a given key path
    func sorted<C: Comparable>(by keyPath: KeyPath<Element, C>) -> Array<Element> {
        return sorted { (left, right) -> Bool in
            let leftComparable = left[keyPath: keyPath]
            let rightComparable = right[keyPath: keyPath]
            return leftComparable < rightComparable
        }
    }
}
