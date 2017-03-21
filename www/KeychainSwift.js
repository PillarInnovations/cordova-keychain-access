var exec = require('cordova/exec');

/*exports.set = function(value, key, keychainAccessOption, success, error) {
  exec(success, error, 'KeychainSwift', 'set', [value, key, keychainAccessOption]);
};*/

exports.echo = function(arg0, success, error) {
  exec(success, error, 'PillarKeychainSwift', 'echo', [arg0]);
};

exports.anotherMethod = function(arg0, success, error) {
  exec(success, error, 'PillarKeychainSwift', 'anotherMethod', [arg0]);
};