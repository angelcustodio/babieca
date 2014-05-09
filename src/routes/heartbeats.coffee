HeartbeatsController = require '../controllers/heartbeats'

heartbeatsRoutes = (app) ->

  heartbeats = new HeartbeatsController

  app.post  '/start_streaming', heartbeats.startStreaming
  app.post  '/store_position', heartbeats.storePosition
  app.post  '/store_position_async', heartbeats.storePosition
  app.post  '/nothing', heartbeats.nothing


module.exports = heartbeatsRoutes