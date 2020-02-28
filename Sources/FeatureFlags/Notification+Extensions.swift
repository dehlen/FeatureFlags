import Foundation

extension Notification.Name {
    /// The notification which is fired when a feature flag is created/updated/deleted
    public static let onRecordsUpdated = Notification.Name("ckFeatureTogglesRecordsUpdatedNotification")
}

extension Notification {
    /// The userInfoKey in which the feature toggles are passed in the fired notification
    public static let featureTogglesUserInfoKey = "featureToggles"
}
