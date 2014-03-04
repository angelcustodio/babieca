express = require 'express'

allowCrossDomain = (req, res, next) ->
  res.header 'Access-Control-Allow-Origin', '*'
  res.header 'Access-Control-Allow-Methods', 'GET, OPTIONS, POST, PUT'
  res.header 'Access-Control-Allow-Headers', 'Content-Type'
  next()

middleware = (app) ->

  app.use express.logger 'dev'

  app.use express.compress()
  app.use express.json()
  app.use express.methodOverride()
  app.use express.urlencoded()

  app.use allowCrossDomain

  app.use app.router

  app.use (req, res) ->
    res.json 404,
      error:
        status: 404
        message: 'Not found'

  app.use express.errorHandler()


module.exports = middleware
