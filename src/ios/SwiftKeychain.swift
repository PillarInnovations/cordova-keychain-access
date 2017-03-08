@objc(ModusEchoSwift) class ModusEchoSwift : CDVPlugin {
@objc(echo:)
func echo(command: CDVInvokedUrlCommand) {
  var pluginResult = CDVPluginResult(
    status: CDVCommandStatus_ERROR
  )

  let msg = command.arguments[0] as? String ?? ""

if msg.characters.count > 0 {
 pluginResult = CDVPluginResult(
   status: CDVCommandStatus_OK,
 messageAsString: msg
 )
}

self.commandDelegate!.sendPluginResult(
  pluginResult,
callbackId: command.callbackId
)
}
}