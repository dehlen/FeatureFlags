/**
 * A Feature uniquely identifies a part of the app code that can either be enabled or disabled.
 * Features only have two states by design to simplify the implementation
 *
 * @param key unique value that identifies a test setting
 */
public protocol Feature {
    var key: String { get }
    var title: String { get }
    var explanation: String { get }
    var defaultValue: Bool { get }
}
