@objc(PillarKeychainSwift) class PillarKeychainSwift : CDVPlugin {
  @objc(set:)
  func set(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let keychain = KeychainSwift()
    keychain.set(command.arguments[0] as String, forKey: command.arguments[1] as String)

    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: "Successfully set key /(command.arguments[1]) with value /(command.arguments[0])"
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
    let result = keychain.get(command.arguments[0] as String)

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