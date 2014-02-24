var express  = require('express'),
    mongoose = require('mongoose'),
    app      = express();

mongoose.connect('mongodb://localhost/babieca', function(error, response){
  if(error)
    console.log('ERROR: ' + error);
  else
    console.log('DB connection succesfull!');
});

app.configure(function(){
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
});

app.get('/', function(request, response){
  response.send('Neigh!');
});

require('./routes')(app);

app.listen(7000);
console.log('Listening to port 7000!');