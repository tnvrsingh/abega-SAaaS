'use strict';
exports.getSampleResponse = function(req, res) {
	var R = require("r-script");

	var out = R("./sentiment.R")
	  .data("#virushkaKiShadi")
	  .callSync();

	console.log(out)

    res.send('Sample /sentiment ' + out)
};

exports.getLOL = function(req, res) {
    res.send('LOL response to /lol ')
};
473570