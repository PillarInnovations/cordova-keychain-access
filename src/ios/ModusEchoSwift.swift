import Security
import Foundation

@objc(ModusEchoSwift) class ModusEchoSwift : CDVPlugin {

  var lastQueryParameters: [String: Any]? // Used by the unit tests

  /// Contains result code from the last operation. Value is noErr (0) for a successful result.
  open var lastResultCode: OSStatus = noErr

  var keyPrefix = "" // Can be useful in test.

  /**
  Specify an access group that will be used to access keychain items. Access groups can be used to share keychain items between applications. When access group value is nil all application access groups are being accessed. Access group name is used by all functions: set, get, delete and clear.
  */
  open var accessGroup: String?


  /**

  Specifies whether the items can be synchronized with other devices through iCloud. Setting this property to true will
   add the item to other devices with the `set` method and obtain synchronizable items with the `get` command. Deleting synchronizable items will remove them from all devices. In order for keychain synchronization to work the user must enable "Keychain" in iCloud settings.

  Does not work on macOS.

  */
  open var synchronizable: Bool = false

  /// Instantiate a KeychainSwift object
  public override init() { }

  /**

  - parameter keyPrefix: a prefix that is added before the key in get/set methods. Note that `clear` method still clears everything from the Keychain.
  */
  public override init(keyPrefix: String) {
    self.keyPrefix = keyPrefix
  }

  /**

  Stores the text value in the keychain item under the given key.

  - parameter key: Key under which the text value is stored in the keychain.
  - parameter value: Text string to be written to the keychain.
  - parameter withAccess: Value that indicates when your app needs access to the text in the keychain item. By default the .AccessibleWhenUnlocked option is used that permits the data to be accessed only while the device is unlocked by the user.

   - returns: True if the text was successfully written to the keychain.
  */
  @discardableResult
  open func set(_ value: String, forKey key: String,
                  withAccess access: KeychainSwiftAccessOptions? = nil) -> Bool {

    if let value = value.data(using: String.Encoding.utf8) {
      return set(value, forKey: key, withAccess: access)
    }

    return false
  }

  @objc(test:)
  func test(command: CDVInvokedUrlCommand) {
    var message = command.arguments[0] as! String

    var pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Hello \(message)")
    commandDelegate.send(pluginResult, callbackId:command.callbackId)
  }
}

public enum KeychainSwiftAccessOptions {

  /**

  The data in the keychain item can be accessed only while the device is unlocked by the user.

  This is recommended for items that need to be accessible only while the application is in the foreground. Items with this attribute migrate to a new device when using encrypted backups.

  This is the default value for keychain items added without explicitly setting an accessibility constant.

  */
  case accessibleWhenUnlocked

  /**

  The data in the keychain item can be accessed only while the device is unlocked by the user.

  This is recommended for items that need to be accessible only while the application is in the foreground. Items with this attribute do not migrate to a new device. Thus, after restoring from a backup of a different device, these items will not be present.

  */
  case accessibleWhenUnlockedThisDeviceOnly

  /**

  The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.

  After the first unlock, the data remains accessible until the next restart. This is recommended for items that need to be accessed by background applications. Items with this attribute migrate to a new device when using encrypted backups.

  */
  case accessibleAfterFirstUnlock

  /**

  The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.

  After the first unlock, the data remains accessible until the next restart. This is recommended for items that need to be accessed by background applications. Items with this attribute do not migrate to a new device. Thus, after restoring from a backup of a different device, these items will not be present.

  */
  case accessibleAfterFirstUnlockThisDeviceOnly

  /**

  The data in the keychain item can always be accessed regardless of whether the device is locked.

  This is not recommended for application use. Items with this attribute migrate to a new device when using encrypted backups.

  */
  case accessibleAlways

  /**

  The data in the keychain can only be accessed when the device is unlocked. Only available if a passcode is set on the device.

  This is recommended for items that only need to be accessible while the application is in the foreground. Items with this attribute never migrate to a new device. After a backup is restored to a new device, these items are missing. No items can be stored in this class on devices without a passcode. Disabling the device passcode causes all items in this class to be deleted.

  */
  case accessibleWhenPasscodeSetThisDeviceOnly

  /**

  The data in the keychain item can always be accessed regardless of whether the device is locked.

  This is not recommended for application use. Items with this attribute do not migrate to a new device. Thus, after restoring from a backup of a different device, these items will not be present.

  */
  case accessibleAlwaysThisDeviceOnly

  static var defaultOption: KeychainSwiftAccessOptions {
    return .accessibleWhenUnlocked
  }

  var value: String {
    switch self {
    case .accessibleWhenUnlocked:
      return toString(kSecAttrAccessibleWhenUnlocked)

    case .accessibleWhenUnlockedThisDeviceOnly:
      return toString(kSecAttrAccessibleWhenUnlockedThisDeviceOnly)

    case .accessibleAfterFirstUnlock:
      return toString(kSecAttrAccessibleAfterFirstUnlock)

    case .accessibleAfterFirstUnlockThisDeviceOnly:
      return toString(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)

    case .accessibleAlways:
      return toString(kSecAttrAccessibleAlways)

    case .accessibleWhenPasscodeSetThisDeviceOnly:
      return toString(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)

    case .accessibleAlwaysThisDeviceOnly:
      return toString(kSecAttrAccessibleAlwaysThisDeviceOnly)
    }
  }

  func toString(_ value: CFString) -> String {
    return KeychainSwiftConstants.toString(value)
  }
}