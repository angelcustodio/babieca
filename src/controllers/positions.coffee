PositionModel = require '../models/position'

class Positions

  # GET /positions
  getAll: (req, res) ->
    try
      PositionModel.find (err, positions) ->
        res.json(404, error: 'Not found') unless positions.length
        res.json positions

    catch error
      res.json(500, error: 'Positions::getAll')


  # GET /positions/users/:user_id
  getByUser: (req, res) ->
    try
      params =
        user_id: req.params.user_id

      PositionModel.find params, (err, positions) ->
        res.json(404, error: 'Not found') unless positions.length
        res.json positions

    catch error
      res.json(500, error: 'Positions::getByUser')


  # GET /positions/contents/:content_id
  getByContent: (req, res) ->
    try
      params =
        content_id: req.params.content_id

      PositionModel.find params, (err, positions) ->
        res.json(404, error: 'Not found') unless positions.length
        res.json positions

    catch error
      res.json(500, error: 'Positions::getByContent')


  # GET /positions/users/:user_id/contents/:content_id
  getOne: (req, res) ->
    try
      params =
        user_id: req.params.user_id
        content_id: req.params.content_id

      PositionModel.findOne params, (err, position) ->
        res.json(404, error: 'Not found') unless position
        res.json position

    catch error
      res.json(500, error: 'Positions::getOne')


  # POST /positions
  createOne: (req, res) ->
    try
      {user_id, content_id, content_type, transaction_type, lapse} = req.body

      position = new PositionModel
        user_id: user_id
        content_id: content_id
        content_type: content_type
        transaction_type: transaction_type
        lapse: lapse
        firstbeat_date: Date.now()
        beats: '1'

      position.save (err) ->
        throw err if err

      res.json position

    catch error
      res.json(500, error: 'Positions::createOne')


  # PUT /positions/:id
  updateOne: (req, res) ->
    try
      PositionModel.findById req.params.id, (err, position) ->

        position.lapse = request.body.lapse
        position.lastbeat_date = Date.now()
        position.beats += 1

        position.save (err) ->
          throw err if err

        res.json position.beats

    catch error
      res.json(500, error: 'Positions::updateOne')



module.exports = Positions
