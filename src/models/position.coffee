mongoose = require 'mongoose'
Schema = mongoose.Schema

positionSchema = new Schema
  user_id: Number
  content_id: Number
  content_type:
    type: String
    enum: [ 'movie', 'episode' ]
  transaction_type:
    type: String
    enum: [ 'rental', 'purchase', 'subscription' ]
  lapse: Number
  firstbeat_date: Date
  lastbeat_date: Date
  beats: Number

module.exports = mongoose.model 'Positions', positionSchema
