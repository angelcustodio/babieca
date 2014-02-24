module.exports = function(app){

  var ResumePlayback = require('./model');

  allPositions = function(request, response){
    ResumePlayback.find(function(error, positions){
      if(!error)
        response.send(positions);
      else
        console.log('ERROR: ' + error);
    });
  };

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

  newPosition = function(request, response){

    // if (request.body.transaction_type === 'rental'){
    //   seconds = 30;
    // } else if (request.body.transaction_type === 'purchase'){
    //   seconds = 90;
    // } else if (request.body.transaction_type === 'subscription'){
    //   seconds = 180;
    // }

    var position = new ResumePlayback({
      user_id:            request.body.user_id,
      content_id:         request.body.content_id,
      content_type:       request.body.content_type,
      transaction_type:   request.body.transaction_type,
      lapse:              request.body.lapse,
      firstbeat_seconds:  Date.now(),
      beats:              '1'
    });
    console.log(seconds);
    position.save(function(error){
      if(error) console.log('ERROR: ' + error);
    });

    response.send(position);

  };

  updatePosition = function(request, response){
    ResumePlayback.findById(request.params.id, function(error, position){

      position.lapse          = request.body.lapse;
      position.lastbeat_time  = Date.now();
      position.beats          = position.beats+1;

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
