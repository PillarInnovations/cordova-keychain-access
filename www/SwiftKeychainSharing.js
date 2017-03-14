var exec = require('cordova/exec');

var SwiftKeychainSharing = {
  serviceName: "SwiftKeychainSharing",

  echo: function(arg0, success, error) {
    exec(success, error, "ModusEchoSwift", "echo", [arg0]);
  },

  echojs: function(arg0, success, error) {
    if (arg0 && typeof(arg0) === 'string' && arg0.length > 0) {
      success(arg0);
    } else {
      error('Empty message!');
    }
  }
};

module.exports = SwiftKeychainSharing;