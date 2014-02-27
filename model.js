var mongoose = require('mongoose'),
    Schema = mongoose.Schema,
    positionSchema = new Schema({
      user_id: Number,
      content_id: Number,
      content_type: {
        type: String,
        enum: ['movie', 'episode']
      },
      transaction_type: {
        type: String,
        enum: ['rental', 'purchase', 'subscription']
      },
      lapse: Number,
      firstbeat_date: Date,
      lastbeat_date: Date,
      beats: Number
      // rental_date: {
      //   type: Date,
      //   expireAfterSeconds: 30
      // },
      // purchase_date: {
      //   type: Date,
      //   expireAfterSeconds: 90
      // },
      // subscription_date: {
      //   type: Date,
      //   expireAfterSeconds: 200
      // }
    });

module.exports = mongoose.model('ResumePlayback', positionSchema);