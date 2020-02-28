import Foundation

extension Notification.Name {
    public static let onRecordsUpdated = Notification.Name("ckFeatureTogglesRecordsUpdatedNotification")
}

extension Notification {
    public static let featureTogglesUserInfoKey = "featureToggles"
}
