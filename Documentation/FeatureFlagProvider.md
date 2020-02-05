# FeatureFlagProvider

Every provider has an explicit priority so they can override each other (e.g. "Remote Config tool" \> Store).
Not every provider has to provide a flag value for every feature. This is to avoid implicitly relying on built-in defaults (e.g. "Remote Config tool" returns false when no value for a feature) and to avoid that every provider has to provide a value for every feature. (e.g. no "Remote Config tool" configuration needed, unless you want the toggle to be remote)

``` swift
public protocol FeatureFlagProvider
```

## Conforming Types

[`RuntimeFeatureFlagProvider`](RuntimeFeatureFlagProvider)

## Required Properties

## priority

The priority of the provider. 0 = highest priority, 3 = minimum priority

``` swift
var priority: Priority
```

## Required Methods

## isFeatureEnabled(feature:)

Returns whether a given feature is enabled or not from the context of the provider.

``` swift
func isFeatureEnabled(feature: Feature) -> Bool
```

  - Parameter feature: The feature to inspect.

### Returns

A bool representing whether the feature is enabled or not.

## hasFeature(feature:)

Returns whether a given feature is handled by the provider or not.

``` swift
func hasFeature(feature: Feature) -> Bool
```

  - Parameter feature: The feature to inspect.

### Returns

A bool representing whether the feature is handled or not.
