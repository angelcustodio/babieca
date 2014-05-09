crypto = require "crypto"
redis = require "redis"
storage = module.exports.client = redis.createClient()

# SECRETS!
cryptkey   = crypto.createHash('sha256').update('Nixnogen').digest()
iv         = 'a2xhcgAAAAAAAAAA'

class Heartbeat
  # @param attributes is a hash with content_id, content_type, base_stream_id,
  # device_type_id, token_created_at, ip_addr
  constructor: (@user_id, @attributes) ->
    @delay_seconds = @constructor.DELAY_SECONDS
    @token = this.encrypt()

  @TOKEN_SEPARATOR: '@'
  @DELAY_SECONDS: 5

  data_to_encrypt: ->
    [
      @user_id,
      @attributes.content_id,
      @attributes.content_type,
      @attributes.base_stream_id,
      @attributes.device_type_id,
      @attributes.token_created_at,
      @attributes.ip_addr
    ].join(@constructor.TOKEN_SEPARATOR)

  encrypt: ->
    cleardata = this.data_to_encrypt()

    encipher = crypto.createCipheriv('aes-256-cbc', cryptkey, iv)
    encryptdata  = encipher.update(cleardata)

    encryptdata += encipher.final('binary')
    encode_encryptdata = new Buffer(encryptdata, 'binary').toString('base64')

  @decrypt_token: (encrypted_data) ->
#    console.log("Data do decrypt is", encrypted_data)
    encryptdata = new Buffer(encrypted_data, 'base64').toString('binary')
#    console.log(encryptdata)
    decipher = crypto.createDecipheriv('aes-256-cbc', cryptkey, iv)
    decoded  = decipher.update(encryptdata)

    decoded += decipher.final('binary')
    decoded

  # Constructs model based on encrypted data
  @decrypt: (encrypted_data, fn) ->
    [ user_id, content_id, content_type, base_stream_id,
    device_type_id, token_created_at, ip_addr] =
      this.decrypt_token(encrypted_data).split(this.TOKEN_SEPARATOR)
    attributes = {
        content_id: content_id,
        content_type: content_type,
        base_stream_id: base_stream_id,
        device_type_id: device_type_id,
        token_created_at: token_created_at,
        ip_addr: ip_addr
      }
    fn(null, new Heartbeat(user_id, attributes))

  @startStreaming: (req, fn) ->
    # 0. Check data?
    # 1. Get current position or create new one
    # 2. Create token
    params = req.body
    heartbeat = new Heartbeat( params.user_id, {
        content_id: params.content_id,
        content_type: params.content_type,
        base_stream_id: params.base_stream_id,
        purchase_type: params.purchase_type,
        device_type_id: params.device_type_id
        })
    heartbeat.load (err) ->
#      console.log(require('util').inspect(heartbeat))
      heartbeat.store ->
        fn(err, heartbeat)

  @storePosition: (req, fn) ->
    params = req.body
    this.decrypt params.token, (err, instance) ->
      instance.position = params.current_position
      instance.store (store_err) ->
        fn(store_err,instance)

  # Loads storage data and updates attributes
  load: (fn) ->
    instance = this # fix me
    this.content_data (err, data) ->
#      console.log("data is ", require('util').inspect(data))
      if !err
        if data
          instance.position = data
        else
          instance.position = 0
        fn(null)
      else
        fn(err)

  store: (fn) ->
    storage.set this.storage_key(), this.position, (err) ->
      fn(err)

  storage_key: ->
    [
      'es',
      'heartbeat',
      'test',
      @user_id,
      @attributes.content_type,
      @attributes.content_id,
    ].join(':')

  # Returns the current content data
  content_data: (fn) ->
    storage.get this.storage_key(), (err, data) ->
      if err
        fn(err, data)
      else
        fn(null, JSON.parse(data))

module.exports = Heartbeat