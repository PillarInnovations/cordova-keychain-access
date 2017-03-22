@objc(PillarKeychainSwift) class PillarKeychainSwift : CDVPlugin {
  @objc(set:)
  func set(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let keychain = KeychainSwift()

    //Check if accessGroup string was sent in
    if command.arguments.count == 3 {
      print("Three arguments in set! Access group is: \(command.arguments[2])")
      keychain.accessGroup = (command.arguments[2] as! String)
    }

    keychain.set(command.arguments[0] as! String, forKey: command.arguments[1] as! String)
    var result = ""
    if command.arguments.count == 3 {
      result = "Successfully set key \(command.arguments[1]) with value \(command.arguments[0]) on access group \(command.arguments[2])"
    } else {
      result = "Successfully set key \(command.arguments[1]) with value \(command.arguments[0])"
    }

    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: result
    )

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

  @objc(get:)
  func get(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let keychain = KeychainSwift()

    //Check if accessGroup string was sent in
    if command.arguments.count == 2 {
      print("Two arguments in get! Access group is: \(command.arguments[1])")
      keychain.accessGroup = (command.arguments[1] as! String)
    }

    let result = keychain.get(command.arguments[0] as! String)
    print("Printing the result in get: \(result)")

    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: result
    )

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

  @objc(delete:)
  func delete(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let keychain = KeychainSwift()

    //Check if accessGroup string was sent in
    if command.arguments.count == 2 {
      keychain.accessGroup = (command.arguments[1] as! String)
    }

    keychain.delete(command.arguments[0] as! String)
    let result = "Successfully deleted key \(command.arguments[0])"

    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: result
    )

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

  @objc(clear:)
  func clear(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let keychain = KeychainSwift()

    //Check if accessGroup string was sent in
    if command.arguments.count == 1 {
      keychain.accessGroup = (command.arguments[0] as! String)
    }

    keychain.clear()
    let result = "Successfully cleared all items from Keychain"

    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: result
    )

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

  @objc(setRaw:)
  func setRaw(command: CDVInvokedUrlCommand) {
    var result = "No result"

    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR,
      messageAs: result
    )

    let itemKey = command.arguments[1] as! String
    let itemValue = command.arguments[0] as! String
    let keychainAccessGroupName = command.arguments[2] as! String
    guard let valueData = itemValue.data(using: String.Encoding.utf8) else {
      print("Error saving text to Keychain")
      result = "Error savings text to Keychain"
      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_ERROR,
        messageAs: result
      )
      return
    }

    let queryAdd: [String: AnyObject] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: itemKey as AnyObject,
      kSecValueData as String: valueData as AnyObject,
      kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked,
      kSecAttrAccessGroup as String: keychainAccessGroupName as AnyObject
    ]

    let resultCode = SecItemAdd(queryAdd as CFDictionary, nil)

    if resultCode != noErr {
      print("Error saving to Keychain: \(resultCode)")
      result = "Error saving to Keychain: \(resultCode)"
      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_ERROR,
        messageAs: result
      )
    } else {
      result = "Raw key set!"
      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_OK,
        messageAs: result
      )
    }

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

  @objc(getRaw:)
  func getRaw(command: CDVInvokedUrlCommand) {
    var resultMessage = "No result"

    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR,
      messageAs: resultMessage
    )

    let itemKey = command.arguments[0] as! String
    let keychainAccessGroupName = command.arguments[1] as! String
    let queryLoad: [String: AnyObject] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: itemKey as AnyObject,
      kSecReturnData as String: kCFBooleanTrue,
      kSecMatchLimit as String: kSecMatchLimitOne,
      kSecAttrAccessGroup as String: keychainAccessGroupName as AnyObject
    ]

    var result: AnyObject?

    let resultCodeLoad = withUnsafeMutablePointer(to: &result) {
      SecItemCopyMatching(queryLoad as CFDictionary, UnsafeMutablePointer($0))
    }

    if resultCodeLoad == noErr {
      if let result = result as? Data,
        let keyValue = NSString(data: result,
                                encoding: String.Encoding.utf8.rawValue) as? String {

        // Found successfully
        print(keyValue)
        pluginResult = CDVPluginResult(
          status: CDVCommandStatus_OK,
          messageAs: keyValue
        )
        //result
      }
    } else {
      print("Error loading from Keychain: \(resultCodeLoad)")
      resultMessage = "Error loading from Keychain: \(resultCodeLoad)"
      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_ERROR,
        messageAs: resultMessage
      )
    }

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }
}