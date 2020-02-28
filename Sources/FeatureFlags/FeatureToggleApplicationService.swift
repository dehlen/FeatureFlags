import Foundation
import CloudKit
#if canImport(UIKit)
import UIKit
#endif

/// Protocol for your feature flag provider
public protocol FeatureToggleApplicationServiceProtocol {
    /// The repository to store the feature flags in
    var featureToggleRepository: FeatureToggleRepository { get }

    #if canImport(UIKit)
    /** Register a UIApplication with the feature flag provider. This is used to retrieve the values on app launch at to update them in real time
    *  @param application The UIApplication instance of your app
    **/
    func register(application: UIApplication)
    /** Register for remote notifications to update feature toggles in real time. This is needed because CloudKit will inform your app about databse changes via a silent push notification
    **/
    func handleRemoteNotification(subscriptionID: String?, completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    #endif
}

/// Concrete implementation of a feature flag provider
public class FeatureToggleApplicationService: NSObject, FeatureToggleApplicationServiceProtocol {
    private var featureToggleSubscriptor: CloudKitSubscriptionProtocol
    private (set) public var featureToggleRepository: FeatureToggleRepository
    
    public convenience init(featureToggleRepository: FeatureToggleRepository = FeatureToggleUserDefaultsRepository()) {
        self.init(featureToggleSubscriptor: FeatureToggleSubscriptor(toggleRepository: featureToggleRepository), featureToggleRepository: featureToggleRepository)
    }
    
    init(featureToggleSubscriptor: CloudKitSubscriptionProtocol, featureToggleRepository: FeatureToggleRepository) {
        self.featureToggleSubscriptor = featureToggleSubscriptor
        self.featureToggleRepository = featureToggleRepository
    }
    
    #if canImport(UIKit)
    /** Register a UIApplication with the feature flag provider. This is used to retrieve the values on app launch at to update them in real time
    *  @param application The UIApplication instance of your app
    **/
    public func register(application: UIApplication) {
        application.registerForRemoteNotifications()
        featureToggleSubscriptor.saveSubscription()
        featureToggleSubscriptor.fetchAll()
    }
    
    /** Register for remote notifications to update feature toggles in real time. This is needed because CloudKit will inform your app about databse changes via a silent push notification
    **/
    public func handleRemoteNotification(subscriptionID: String?, completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let subscriptionID = subscriptionID, featureToggleSubscriptor.subscriptionID == subscriptionID {
            featureToggleSubscriptor.handleNotification()
            completionHandler(.newData)
        }
        else {
            completionHandler(.noData)
        }
    }
    #endif
}

#if canImport(UIKit)
extension FeatureToggleApplicationService: UIApplicationDelegate {
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        register(application: application)
        
        return true
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        guard let notification = CKNotification(fromRemoteNotificationDictionary: userInfo), let subscriptionID = notification.subscriptionID else {
            return
        }
        
        handleRemoteNotification(subscriptionID: subscriptionID, completionHandler: completionHandler)
    }
}
#endif
