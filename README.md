# Feature Flags
<img src="https://img.shields.io/badge/supports-Swift%20Package%20Manager-green.svg">
<img src="./docs/badge.svg">
<img src="https://img.shields.io/badge/Swift-5-orange">
<img src="https://img.shields.io/badge/Platforms-iOS | macOS-lightgrey">

Feature Toggles offer a way to enable or disable certain features that are present in your codebase, switch environments or configurations or toggle between multiple implementations of a protocol - even in your live system at runtime. *Feature Flags* are implemented using `CloudKit` and are therefor associated with no run costs for the developer. Existing Feature Toggles can be changed in the [CloudKit Dashboard](https://icloud.developer.apple.com/dashboard/) and are delivered immediately via silent push notifications to your users.

## Installation

Currently only Swift Package Manager is supported. 
Swift Package Manager is a dependency manager built into Xcode.

If you are using Xcode 11 or higher, go to File / Swift Packages / Add Package Dependency... and enter package repository URL https://github.com/dehlen/FeatureFlags.git, then follow the instructions.

To remove the dependency, select the project and open Swift Packages (which is next to Build Settings). You can add and remove packages from this tab.

## Usage

### CloudKit Preparations
1. If your application does not support CloudKit yet start with adding the `CloudKit` and `remote background notification` entitlements to your application
2. Add a new custom record type 'FeatureStatus' with two fields:

| Field | Type |
| --- | --- |
| `featureName` | `String` |
| `isActive` | `Int64` |

For each feature toggle you want to support in your application later add a new record in your CloudKit *public database*. 

### In your project
1. In your AppDelegate, initialize a `FeatureToggleApplicationService` and hook its two `UIApplicationDelegate` methods into the AppDelegate lifecycle like so: 

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return featureToggleApplicationService.application(application, didFinishLaunchingWithOptions: launchOptions)
}

func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        featureToggleApplicationService.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
}

```
2. Anywhere in your code you can create an instance of `FeatureToggleUserDefaultsRepository` and call `retrieve` to fetch the current status of a feature toggle.

> :warning: Note that `retrieve` returns the locally saved status of your toggle, this command does not trigger a fetch from CloudKit. Feature Toggles are fetched from CloudKit once at app start from within the `FeatureToggleApplicationService` `UIApplicationDelegate` hook. Additionally you can subscribe to updates whenever there was a change to the feature toggles in CloudKit as shown in the next section. 

3. You have to call `retrieve` with your implementation of a `FeatureToggleIdentifiable`. What I think works well is creating an enum which implements `FeatureToggleIdentifiable`:

```swift
enum FeatureToggle: String, FeatureToggleIdentifiable {
    case feature1
    case feature2
    
    var identifier: String {
        return self.rawValue
    }
    
    var fallbackValue: Bool {
        switch self {
        case .feature1:
            return false
        case .feature2:
            return true
        }
    }
}
``` 

### Notifications

You can subscribe to updates from your feature toggles in CloudKit by subscribing to the `onRecordsUpdated` Notification like so:

```swift
NotificationCenter.default.addObserver(self, selector: #selector(updateToggleStatusFromNotification), name: NSNotification.Name.onRecordsUpdated, object: nil)
```

```
@objc
private func updateToggleStatusFromNotification(notification NSNotification) {
    guard let updatedToggles = notification.userInfo[Notification.featureToggleUserInfoKey] as? [FeatureToggle] else {
        return
    }
    
    // do something with the updated toggle like e.g. disabling UI elements 
}
```

Note that the updated Feature Toggles are attached to the notifications userInfo dictionary. When this notification has been sent the updated values are also already stored in the repository.   

## Documentation
The documentation is generated thanks to [jazzy](https://github.com/realm/jazzy).

You can find the latest version here: [Documentation](./docs).

## License
The MIT License

Copyright (c) 2020 David Ehlen

See LICENSE file

