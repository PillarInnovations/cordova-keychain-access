var exec = require('cordova/exec');

exports.set = function(value, key, success, error) {
  exec(success, error, 'PillarKeychainSwift', 'set', [value, key]);
};

exports.get = function(key, success, error) {
  exec(success, error, 'PillarKeychainSwift', 'get', [key]);
};