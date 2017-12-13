var cors = require('cors')
module.exports = function(app) {
  // Abega
  //
  var abega = require('../controllers/Controller');

  app.get('/',function(req,res){
    res.render('home');
  });

  app.get('/sentiment',function(req,res){
    res.render('index', {name: 'LOL'});
  });

  // Abega routes
  app.route('/sentimentdata').get(abega.getSampleResponse);

  // Handle 404
  app.use(function(req, res, next) {
   if(req.accepts('html') && res.status(404)) {
  //        res.render('404.jade');
       res.send(req.originalUrl)
       return;
   }
  });
};
