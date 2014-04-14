mongoose = require 'mongoose'

database = (app) ->

  app.config.mongodb =
    hostname: 'localhost'
    database: 'babieca'

  conn = "mongodb://#{app.config.mongodb.hostname}/#{app.config.mongodb.database}"

  app.database = mongoose.connect conn, (err, res) ->
    throw err if err
    console.info "✔ Connected to the database '#{app.config.mongodb.database}'"


module.exports = database
