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
      keychain.accessGroup = command.arguments[2] as! String
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
      keychain.accessGroup = command.arguments[1] as! String
    }

    let result = keychain.get(command.arguments[0] as! String)

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
      keychain.accessGroup = command.arguments[1] as! String
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
      keychain.accessGroup = command.arguments[0] as! String
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
}