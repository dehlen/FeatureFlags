# Feature

A Feature uniquely identifies a part of the app code that can either be enabled or disabled.
Features only have two states by design to simplify the implementation.

``` swift
public protocol Feature
```

## Required Properties

## key

Unique value that identifies a test setting.

``` swift
var key: String
```

## title

Title of the feature flag. Currently not used. You could use this to build a debug setting with a table to disable/enable feature flags.

``` swift
var title: String
```

## explanation

Explanation of the feature flag. You could use this to build a debug setting with a table to disable/enable feature flags.

``` swift
var explanation: String
```

## defaultValue

The default value of the feature, which is used if the given provider does not override the features value.

``` swift
var defaultValue: Bool
```
