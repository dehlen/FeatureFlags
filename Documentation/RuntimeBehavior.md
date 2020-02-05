# RuntimeBehavior

Check whether a feature should be enabled or not. Based on the priority of the different providers and if said provider explicitly defines a value for that feature, the value of the flag is returned.

``` swift
public class RuntimeBehavior
```

## Initializers

## init(providers:)

Init with a given set of providers.

``` swift
public init(providers: [FeatureFlagProvider])
```

## Properties

## providers

The registered providers

``` swift
var providers = [FeatureFlagProvider]()
```

## Methods

## isFeatureEnabled(feature:)

Returns whether a given feature is enabled or not from the context of the provider.
The first provider with the highest priority which handles the given feature returns the value else the features default value is returned.

``` swift
public func isFeatureEnabled(feature: Feature) -> Bool
```

  - Parameter feature: The feature to inspect.

### Returns

A bool representing whether the feature is enabled or not.

## refreshFeatureFlags()

For every registered provider refreshFeatureFlags() is called

``` swift
public func refreshFeatureFlags()
```

## addProvider(provider:)

Registers the given provider.

``` swift
public func addProvider(provider: FeatureFlagProvider)
```

  - Parameter provider: The provider to register.

## clearFeatureFlagProviders()

Removes all registered providers.

``` swift
public func clearFeatureFlagProviders()
```

## removeAllFeatureFlagProviders(priority:)

Removes all registered providers with the given priority.

``` swift
public func removeAllFeatureFlagProviders(priority: Priority)
```

  - Parameter priority: The priority for which providers should be removed.
