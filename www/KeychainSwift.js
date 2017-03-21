var exec = require('cordova/exec');

exports.set = function(value, key, success, error, accessGroup) {
  if(accessGroup) {
    console.log("access group is defined in set: ", accessGroup);
    exec(success, error, 'PillarKeychainSwift', 'set', [value, key, accessGroup]);
  } else {
    exec(success, error, 'PillarKeychainSwift', 'set', [value, key]);
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