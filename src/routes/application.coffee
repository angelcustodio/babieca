ApplicationController = require '../controllers/application'

applicationRoutes = (app) ->

  application = new ApplicationController

  app.get '/', application.sayHi


module.exports = applicationRoutes
