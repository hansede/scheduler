google_validation = require './google_validation'

auth_cache = {}

init = (router) ->
  router.all '/api/*', (req, res, next) ->
    auth_header = req.headers.authorization
    if not auth_header? then return res.sendStatus(401)
    google_token = auth_header.split(' ').pop()

    if google_token of auth_cache
      req.body.google_id = auth_cache[google_token]
      next()

    else
      google_validation.validate google_token, (google_id) ->
        if not google_id? then return res.sendStatus(401)
        else
          debugger
          auth_cache[google_token] = google_id
          req.body.google_id = google_id
          next()

module.exports =
  init: init