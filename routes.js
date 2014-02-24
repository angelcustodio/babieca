module.exports = function(app){

  var ResumePlayback = require('./model');

  // GET All
  allPositions = function(request, response){
    ResumePlayback.find(function(error, positions){
      if(!error)
        response.send(positions);
      else
        console.log('ERROR: ' + error);
    });
  };

  // GET One
  getPosition = function(request, response){
    ResumePlayback.findById(request.params.id, function(error, position){
      if(!error)
        response.send(position);
      else
        console.log('ERROR: ' + error);
    });
  };

  // POST
  newPosition = function(request, response){
    console.log('POST');
    console.log(request.body);

    var position = new ResumePlayback({
      content_id:   request.body.content_id,
      content_type: request.body.content_type,
      user_id:      request.body.user_id,
      lapse:        request.body.lapse
    });

    position.save(function(error){
      if(!error)
        console.log('New position saved!');
      else
        console.log('ERROR: ' + error);
    });

    response.send(position);

  };

  // PUT
  updatePosition = function(request, response){
    ResumePlayback.findById(request.params.id, function(error, position){
      position.lapse = request.body.lapse;
      position.save(function(error){
        if(!error)
          console.log('Position updated!');
        else
          console.log('ERROR: ' + error);
      });
    });
  };

  // Routes
  app.get('/positions', allPositions);
  app.get('/position/:id', getPosition);
  app.post('/position', newPosition);
  app.put('/position/:id', updatePosition);

}
