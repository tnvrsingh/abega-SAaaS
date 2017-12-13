process.env.NODE_ENV = 'development';
var R = require("r-script");
var cors = require('cors')
var express = require('express'),
  app = express(),
  port = process.env.PORT || 3000;
  model = require('./models/Model'), //created model loading here
  bodyParser = require('body-parser');

  app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});	

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use('/assets', express.static(process.cwd() + '/assets/'));
app.set('view engine', 'ejs');

// app.use(function(req, res) {
//   res.status(404).send({url: req.originalUrl + ' not found'})
// });

var routes = require('./routes/Routes'); //importing route
routes(app); //register the route

app.listen(port);

console.log('Abega RESTful API server started on: ' + port);
