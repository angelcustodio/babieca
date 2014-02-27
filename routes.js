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

  getUserPositions = function(request, response){
    ResumePlayback.find({
        'user_id':    request.params.user_id
      }, function(error, positions){
        if(!error)
          response.send(positions);
        else
          console.log('ERROR: ' + error);
      });
  };

  getContentPositions = function(request, response){
    ResumePlayback.find({
        'content_id':    request.params.content_id
      }, function(error, positions){
        if(!error)
          response.send(positions);
        else
          console.log('ERROR: ' + error);
      });
  };

  getPosition = function(request, response){
    ResumePlayback.findOne({
        'user_id':    request.params.user_id,
        'content_id': request.params.content_id
      }, function(error, position){
        if(!error)
          response.send(position.id);
        else
          console.log('ERROR: ' + error);
      });
  };

  newPosition = function(request, response){
    if (request.body.transaction_type === 'rental'){
      var rental_date_var = Date.now();
    } else if (request.body.transaction_type === 'purchase'){
      var purchase_date_var = Date.now();
    } else if (request.body.transaction_type === 'subscription'){
      var subscription_date_var = Date.now();
    }
    var position = new ResumePlayback({
      user_id:            request.body.user_id,
      content_id:         request.body.content_id,
      content_type:       request.body.content_type,
      transaction_type:   request.body.transaction_type,
      lapse:              request.body.lapse,
      firstbeat_date:     Date.now(),
      beats:              '1',
      rental_date:         null || rental_date_var,
      purchase_date:       null || purchase_date_var,
      subscription_date:   null || subscription_date_var
    });

    position.save(function(error){
      if(error) console.log('ERROR: ' + error);
    });

    response.send(position);

  };

  updatePosition = function(request, response){
    ResumePlayback.findById(request.params.id, function(error, position){

      position.lapse          = request.body.lapse;
      position.lastbeat_date  = Date.now();
      position.beats          = position.beats+1;

      position.save(function(error){
        if(error) console.log('ERROR: ' + error);
      });
    });
  };

  // Routes
  app.get('/positions', allPositions);
  app.get('/user/:user_id', getUserPositions);
  app.get('/content/:content_id', getContentPositions);
  app.get('/position/:user_id/:content_id', getPosition);
  app.post('/position', newPosition);
  app.put('/position/:id', updatePosition);

}
