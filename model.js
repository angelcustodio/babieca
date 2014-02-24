var mongoose = require('mongoose'),
    Schema = mongoose.Schema,
    positionSchema = new Schema({
      content_id: Number,
      content_type: String,
      user_id: Number,
      lapse: Number
    });

module.exports = mongoose.model('ResumePlayback', positionSchema);