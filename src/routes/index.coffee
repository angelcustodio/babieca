routes = (app) ->

  require('./application')(app)
  require('./positions')(app)
  require('./heartbeats')(app)

  app.use (req, res) ->
      res.json 404,
        error:
          status: 404
          message: 'Not found'

module.exports = routes
