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

  // GET Position ID
  getPosition = function(request, response){
    ResumePlayback.findOne({
        'user_id': request.params.user_id,
        'content_id': request.params.content_id
      }, function(error, position){
        if(!error)
          response.send(position.id);
        else
          console.log('ERROR: ' + error);
      });
  };

  // POST a new position
  newPosition = function(request, response){

    var position = new ResumePlayback({
      content_id:   request.body.content_id,
      content_type: request.body.content_type,
      user_id:      request.body.user_id,
      lapse:        request.body.lapse
    });

    position.save(function(error){
      if(error) console.log('ERROR: ' + error);
    });

    response.send(position);

  };

  // PUT a position
  updatePosition = function(request, response){
    ResumePlayback.findById(request.params.id, function(error, position){
      position.lapse = request.body.lapse;
      position.save(function(error){
        if(error) console.log('ERROR: ' + error);
      });
    });
  };

  // Routes
  app.get('/positions', allPositions);
  app.get('/position/:user_id/:content_id', getPosition);
  app.post('/position', newPosition);
  app.put('/position/:id', updatePosition);

}
