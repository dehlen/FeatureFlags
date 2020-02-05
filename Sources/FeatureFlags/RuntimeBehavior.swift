/**
 * Check whether a feature should be enabled or not. Based on the priority of the different providers and if said
 * provider explicitly defines a value for that feature, the value of the flag is returned.
 */
public class RuntimeBehavior {
    private(set) public var providers = [FeatureFlagProvider]()

    public init(providers: [FeatureFlagProvider]) {
        self.providers = providers
    }

    public func isFeatureEnabled(feature: Feature) -> Bool {
        guard let provider = providers
            .filter({ $0.hasFeature(feature: feature) })
            .sorted(by: \.priority)
            .first else {
            return feature.defaultValue
        }
        return provider.isFeatureEnabled(feature: feature)
    }

    public func refreshFeatureFlags() {
        providers
            .compactMap { $0 as? RemoteFeatureFlagProvider }
            .forEach { $0.refreshFeatureFlags() }
    }

    public func addProvider(provider: FeatureFlagProvider) {
        providers.append(provider)
    }

    public func clearFeatureFlagProviders() {
        providers.removeAll()
    }

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
