express = (app) ->

  app.configure ->
    app.set 'port', app.config.port


module.exports = express
