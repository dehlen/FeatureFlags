import Foundation
import CloudKit

/// Protocol representing a feature flag
public protocol FeatureToggleRepresentable {
    /// The identifier of the feature flag. Should be unique
    var identifier: String { get }
    /// Whether the feature flag is active or not.
    var isActive: Bool { get }
}

/// Protocol identifieing a feature flag
public protocol FeatureToggleIdentifiable {
    /// The identifier of the feature flag. Should be unique
    var identifier: String { get }
    /// The fallback value. Will be used if no information is given about whether the feature flag is active or not. This can happen for example if the CloudKit sync failed.
    var fallbackValue: Bool { get }
}

/// Concrete implementation of a feature flag
public struct FeatureToggle: FeatureToggleRepresentable, Equatable {
    /// The identifier of the feature flag. Should be unique
    public let identifier: String
    /// Whether the feature flag is active or not.
    public let isActive: Bool
}

protocol FeatureToggleMappable {
    func map(record: CKRecord) -> FeatureToggle?
}

class FeatureToggleMapper: FeatureToggleMappable {
    private let featureToggleNameFieldID: String
    private let featureToggleIsActiveFieldID: String
    
    init(featureToggleNameFieldID: String, featureToggleIsActiveFieldID: String) {
        self.featureToggleNameFieldID = featureToggleNameFieldID
        self.featureToggleIsActiveFieldID = featureToggleIsActiveFieldID
    }
    
    func map(record: CKRecord) -> FeatureToggle? {
        guard let isActive = record[featureToggleIsActiveFieldID] as? Int64, let featureName = record[featureToggleNameFieldID] as? String else {
            return nil
        }
        
        return FeatureToggle(identifier: featureName, isActive: NSNumber(value: isActive).boolValue)
    }
}
