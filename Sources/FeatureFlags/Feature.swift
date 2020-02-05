///  A Feature uniquely identifies a part of the app code that can either be enabled or disabled.
///  Features only have two states by design to simplify the implementation.
///
public protocol Feature {
    /// Unique value that identifies a test setting.
    var key: String { get }
    
    /// Title of the feature flag. Currently not used. You could use this to build a debug setting with a table to disable/enable feature flags.
    var title: String { get }
    
    /// Explanation of the feature flag. You could use this to build a debug setting with a table to disable/enable feature flags.
    var explanation: String { get }
    
    /// The default value of the feature, which is used if the given provider does not override the features value.
    var defaultValue: Bool { get }
}
