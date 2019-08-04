'use strict';
var parse = require('@iarna/toml/parse-string');

exports._parse = function(left, right, input) {
    try {
        return right(parse(input));
    } catch (err) {
        return left(err.message);
    }
}
