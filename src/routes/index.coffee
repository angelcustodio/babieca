routes = (app) ->

  require('./application')(app)
  require('./positions')(app)


module.exports = routes
