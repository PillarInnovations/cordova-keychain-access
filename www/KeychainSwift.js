var exec = require('cordova/exec');

exports.set = function(value, key, success, error, accessGroup) {
  if(accessGroup) {
    console.log("access group is defined in set: ", accessGroup);
    exec(success, error, 'PillarKeychainSwift', 'set', [value, key, accessGroup]);
  } else {
    exec(success, error, 'PillarKeychainSwift', 'set', [value, key]);
  }
};

exports.setRaw = function(value, key, success, error, accessGroup) {
  if(accessGroup) {
    console.log("access group is defined in setRaw: ", accessGroup);
    exec(success, error, 'PillarKeychainSwift', 'setRaw', [value, key, accessGroup]);
  } else {
    exec(success, error, 'PillarKeychainSwift', 'setRaw', [value, key]);
  }
};

exports.get = function(key, success, error, accessGroup) {
  if(accessGroup) {
    console.log("access group is defined in get: ", accessGroup);
    exec(success, error, 'PillarKeychainSwift', 'get', [key, accessGroup]);
  } else {
    exec(success, error, 'PillarKeychainSwift', 'get', [key]);
  }
};

exports.getRaw = function(key, success, error, accessGroup) {
  if(accessGroup) {
    console.log("access group is defined in getRaw: ", accessGroup);
    exec(success, error, 'PillarKeychainSwift', 'getRaw', [key, accessGroup]);
  } else {
    exec(success, error, 'PillarKeychainSwift', 'getRaw', [key]);
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

//need to pass in params for synchronizable, withAccess, keyPrefix
//getBool and getData were giving me issues in XCode