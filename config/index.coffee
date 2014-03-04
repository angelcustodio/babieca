config = (app) ->

  require('./application')(app)
  require('./database')(app)
  require('./express')(app)
  require('./middleware')(app)


module.exports = config
