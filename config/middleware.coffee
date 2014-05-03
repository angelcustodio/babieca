express = require 'express'
logger = require 'morgan'
compress = require 'compression'
bodyParser = require 'body-parser'
methodOverride = require 'method-override'
errorHandler = require 'errorhandler'

allowCrossDomain = (req, res, next) ->
  res.header 'Access-Control-Allow-Origin', '*'
  res.header 'Access-Control-Allow-Methods', 'GET, OPTIONS, POST, PUT'
  res.header 'Access-Control-Allow-Headers', 'Content-Type'
  next()

middleware = (app) ->

	app.use logger 'dev'
	app.use compress()
	app.use bodyParser()
	app.use methodOverride()
	app.use allowCrossDomain
	app.use errorHandler()

module.exports = middleware
