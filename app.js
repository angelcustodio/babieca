var express  = require('express'),
    mongoose = require('mongoose'),
    app      = express(),
    port     = 7000,
    allowCrossDomain = function(req, res, next) {
      res.header('Access-Control-Allow-Origin', '*'); // NOT SAFE FOR PRODUCTION
      res.header('Access-Control-Allow-Methods', 'GET, PUT, POST');
      res.header('Access-Control-Allow-Headers', 'Content-Type');
      next();
    };

app.configure(function(){
  app.use(allowCrossDomain);
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
});

mongoose.connect('mongodb://localhost/babieca', function(error, response){
  if(error) console.log('ERROR: ' + error);
});

app.get('/', function(request, response){
  response.send('Neigh!');
});

require('./routes')(app);

app.listen(port);
console.log('Listening to port %s!', port);