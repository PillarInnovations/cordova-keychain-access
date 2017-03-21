var exec = require('cordova/exec');

exports.test = function(arg0, success, error) {
  exec(success, error, 'ModusEchoSwift', 'test', [arg0]);
};

exports.set = function(value, key, keychainAccessOption, success, error) {
  exec(success, error, 'ModusEchoSwift', 'set', [value, key, keychainAccessOption]);
};
