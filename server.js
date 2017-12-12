var R = require("r-script");
var express = require('express'),
  app = express(),
  port = process.env.PORT || 3000;
  model = require('./api/models/Model'), //created model loading here
  bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// app.use(function(req, res) {
//   res.status(404).send({url: req.originalUrl + ' not found'})
// });

var routes = require('./api/routes/Routes'); //importing route
routes(app); //register the route

app.listen(port);

console.log('Abega RESTful API server started on: ' + port);
