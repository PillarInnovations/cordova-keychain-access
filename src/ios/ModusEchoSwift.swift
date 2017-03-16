@objc(ModusEchoSwift) class ModusEchoSwift : CDVPlugin {


  func greet(command: CDVInvokedUrlCommand) {
    var message = command.arguments[0] as! String

    var pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Hello \(message)")
    commandDelegate.send(pluginResult, callbackId:command.callbackId)
  }
}