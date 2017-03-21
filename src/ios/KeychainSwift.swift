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

  @objc(anotherMethod:)
  func anotherMethod(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let obj = KeychainSwift()
    let reflected = reflect(obj)
    var members = [String: String]()
    for index in 0..<reflected.count {
       members[reflected[index].0] = reflected[index].1.summary
    }
    println(members)
    //keychain.set("hello world", forKey: "testKey")
    //let result = keychain.get("testKey")
    let result = "dood"

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