var exec = require('cordova/exec');

var SwiftKeychainSharing = {
  serviceName: "SwiftKeychainSharing",

  set: function(arg0, success, error) {
    exec(success, error, "SwiftKeychainSharing", "set", [arg0]);
  }
};

module.exports = SwiftKeychainSharing;