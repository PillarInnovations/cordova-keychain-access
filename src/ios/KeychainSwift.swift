@objc(KeychainSwift) class KeychainSwift : CDVPlugin {
  @objc(echo:)
  func echo(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let msg = command.arguments[0] as? String ?? ""

    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: msg
    )

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }
}