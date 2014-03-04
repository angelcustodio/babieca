PositionsController = require '../controllers/positions'

positionsRoutes = (app) ->

  positions = new PositionsController

  app.get   '/positions', positions.getAll

  app.get   '/user/:user_id', positions.getByUser
  app.get   '/content/:content_id', positions.getByContent

  app.post  '/position', positions.createOne
  app.put   '/position/:id', positions.updateOne

  app.get   '/position/:user_id/:content_id', positions.getOne


module.exports = positionsRoutes
