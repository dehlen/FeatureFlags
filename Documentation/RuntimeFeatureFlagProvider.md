# RuntimeFeatureFlagProvider

Implements a FeatureFlagProvider which stores the feature flag in UserDefaults.

``` swift
public class RuntimeFeatureFlagProvider: FeatureFlagProvider
```

## Inheritance

[`FeatureFlagProvider`](FeatureFlagProvider)

## Initializers

## init(preferences:priority:)

Init the provider with a given UserDefaults and priority.
Defaults to `UserDefaults.standard` and `Priority.medium`

``` swift
public init(preferences: UserDefaults = UserDefaults.standard, priority: Priority = .medium)
```

## Properties

## priority

The priority of the provider.

``` swift
var priority: Priority
```

## Methods

## isFeatureEnabled(feature:)

Returns whether a given feature is enabled or not from the context of the provider.
If the feature with its key is found in the provided UserDefaults, the stored value is returned else the features default value.

``` swift
public func isFeatureEnabled(feature: Feature) -> Bool
```

  - Parameter feature: The feature to inspect.

### Returns

A bool representing whether the feature is enabled or not.

## hasFeature(feature:)

Returns whether a given feature is handled by the provider or not.

``` swift
public func hasFeature(feature: Feature) -> Bool
```

  - Parameter feature: The feature to inspect.

### Returns

A bool representing whether the feature is handled or not.

## setFeatureEnabled(feature:enabled:)

Sets the enabled state for a given feature by storing a key/value pair in the UserDefaults.

``` swift
public func setFeatureEnabled(feature: Feature, enabled: Bool)
```

  - Parameter feature: The feature for which the enabled state should be mutated.

<!-- end list -->

  - Parameter enabled: Whether the feature should be enabled or not.
