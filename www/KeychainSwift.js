var exec = require('cordova/exec');

exports.set = function(value, key, success, error, accessGroup) {
  if(accessGroup) {
    exec(success, error, 'PillarKeychainSwift', 'set', [value, key, accessGroup]);
  } else {
    exec(success, error, 'PillarKeychainSwift', 'set', [value, key]);
  }
};

exports.get = function(key, success, error, accessGroup) {
  if(accessGroup) {
    exec(success, error, 'PillarKeychainSwift', 'get', [key, accessGroup]);
  } else {
    exec(success, error, 'PillarKeychainSwift', 'get', [key]);
  }
};

exports.delete = function(key, success, error, accessGroup) {
  if(accessGroup) {
    exec(success, error, 'PillarKeychainSwift', 'delete', [key, accessGroup]);
  } else {
    exec(success, error, 'PillarKeychainSwift', 'delete', [key]);
  }
};

exports.clear = function(success, error, accessGroup) {
  if(accessGroup) {
    exec(success, error, 'PillarKeychainSwift', 'clear', [accessGroup]);
  } else {
    exec(success, error, 'PillarKeychainSwift', 'clear');
  }
};

exports.getData = function(key, success, error) {
  exec(success, error, 'PillarKeychainSwift', 'getData', [key]);
};

//need to pass in params for synchronizable, withAccess, keyPrefix
//getBool was giving me issues in XCode