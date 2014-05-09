HeartbeatModel = require '../models/heartbeat'

class Heartbeats

  startStreaming: (req, res) ->
    try
      HeartbeatModel.startStreaming req, (err, instance) ->
        console.log("on controller gets",require("util").inspect(instance))
        res.json {
          token: instance.token,
          position: instance.position,
          delay_seconds: instance.delay_seconds
        }

    catch error
      console.trace(error)
      res.json(500, error: require('util').inspect(error))

  storePosition: (req, res) ->
    try
      HeartbeatModel.storePosition req, (err, instance) ->
        #console.log("on controller gets",require("util").inspect(instance))
        res.json {
          token: instance.token,
          position: instance.position,
          delay_seconds: instance.delay_seconds
        }

    catch error
      console.log(error)
      res.json(500, error: require('util').inspect(error))

  storePositionQueued: (req, res) ->
    try
      HeartbeatModel.storePosition req, (err, instance) ->
        #console.log("on controller gets",require("util").inspect(instance))
        if !err
          console.log("storePositionQueued ends with success")
        else
          console.error("storePositionQueued ends with error")
          console.log(error)

      res.json {"status":"queued"}
      res.end()

    catch error
      console.log(error)
      res.json(500, error: require('util').inspect(error))



module.exports = Heartbeats
