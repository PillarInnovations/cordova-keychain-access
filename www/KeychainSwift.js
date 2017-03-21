var exec = require('cordova/exec');

exports.set = function(value, key, success, error) {
  exec(success, error, 'PillarKeychainSwift', 'set', [value, key]);
};

exports.get = function(key, success, error) {
  exec(success, error, 'PillarKeychainSwift', 'get', [key]);
};

exports.delete = function(key, success, error) {
  exec(success, error, 'PillarKeychainSwift', 'delete', [key]);
};

exports.clear = function(success, error) {
  exec(success, error, 'PillarKeychainSwift', 'clear');
};

exports.getBool = function(key, success, error) {
  exec(success, error, 'PillarKeychainSwift', 'getBool', [key]);
};

exports.getData = function(key, success, error) {
  exec(success, error, 'PillarKeychainSwift', 'getData', [key]);
};

//pass in params for synchronizable, withAccess, accessGroup, keyPrefix