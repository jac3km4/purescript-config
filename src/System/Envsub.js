'use strict';
var envsub = require('envsub/js/envsub-parser');

exports.populate = function(template) {
    var options = {
        options: {
            syntax: 'default',
            protect: true,
            envFiles: ['.env']
        }
    };
    return envsub(template, options);
}
