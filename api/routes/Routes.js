module.exports = function(app) {

  // Abega
  var abega = require('../controllers/Controller');

  // Abega routes
  app.route('/sentiment')
     .get(abega.getSampleResponse);
    // .post(todoList.create_a_task);

  app.route('/lol')
     .get(abega.getLOL);

  // Handle 404
  app.use(function(req, res, next) {
   if(req.accepts('html') && res.status(404)) {
  //        res.render('404.jade');
       res.send('<h1>zzzzzzzzzzzzzzzzzz</h1>')
       return;
   }
  });
};
