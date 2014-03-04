path = require 'path'

application = (app) ->

  app.config =
    port: 7000
    root: path.normalize "#{__dirname}/.."


module.exports = application
