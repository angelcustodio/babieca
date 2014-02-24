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
      firstbeat_time: Date,
      lastbeat_time: Date,
      beats: Number,
      // Add the capability to modify this depending on the content_type
      created_at: {
        type: Date,
        default: Date.now(),
        expires: 100
      }
    });

module.exports = mongoose.model('ResumePlayback', positionSchema);