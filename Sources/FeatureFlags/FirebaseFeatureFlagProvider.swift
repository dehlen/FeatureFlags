#warning("uncomment once we can integrate Firebase via SPM")
//import Foundation
//
//class FirebaseFeatureFlagProvider: FeatureFlagProvider, RemoteFeatureFlagProvider {
//    private let remoteConfig: RemoteConfig = RemoteConfig.remoteConfig()
//    private let developerModeEnabled: Bool
//    var priority: Priority = .max
//
//    init(developerModeEnabled: Bool) {
//        self.developerModeEnabled = developerModeEnabled
//
//        let configSettings = RemoteConfigSettings(developerModeEnabled: developerModeEnabled)
//        remoteConfig.configSettings = configSettings
//    }
//
//    func isFeatureEnabled(feature: Feature) -> Bool {
//        remoteConfig[feature.key].boolValue
//    }
//
//    func hasFeature(feature: Feature) -> Bool {
//        return true
//    }
//
//    func refreshFeatureFlags() {
//        remoteConfig.fetch(withExpirationDuration: getCacheExpirationSeconds(isDevModeEnabled: developerModeEnabled)) { (status, _) in
//            switch status {
//            case .success:
//                remoteConfig.activateFetched()
//            default: ()
//            }
//        }
//    }
//
//    private func getCacheExpirationSeconds(isDevModeEnabled: Bool) -> TimeInterval {
//        if (isDevModeEnabled) {
//            return 1 * 60 * 60
//        } else {
//            return 1
//        }
//    }
//}
