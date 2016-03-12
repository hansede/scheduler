request = require 'request'
env = require './environment'

TOKEN_INFO_URL = 'https://www.googleapis.com/oauth2/v3/tokeninfo'

validate = (id_token, callback) ->
  request "#{TOKEN_INFO_URL}?id_token=#{id_token}", (err, response, body) ->
    debugger
    if err? or not body? then callback(null)
    else if response.statusCode isnt 200 then callback(null)
    else
      json = JSON.parse(body)

      if json.aud is env.client_id
        callback(json.sub)
      else callback(null)

module.exports =
  validate: validate