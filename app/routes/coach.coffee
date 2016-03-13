request = require 'request'
env = require '../environment'

get = (req, res) ->
  request "#{env.service_url}/api/coach?email=#{req.query.email}", (err, response, body) ->
    if err? or not body? then return res.sendStatus 500
    else if response.statusCode isnt 200 then return res.sendStatus(response.statusCode)

    json = JSON.parse(body)

    if not json.length then return res.sendStatus 404
    else return res.send(json[0])

get_by_id = (req, res) ->
  request "#{env.service_url}/api/coach/#{req.params.id}", (err, response, body) ->
    if err? or not body? then return res.sendStatus(500)
    else if response.statusCode isnt 200 then return res.sendStatus(response.statusCode)
    else res.send(JSON.parse(body))

post = (req, res) ->
  params =
    form:
      google_id: req.body.google_id
      name: req.body.name
      email: req.body.email
      phone: req.body.phone
      avatar: req.body.avatar

  request.post "#{env.service_url}/api/coach", params, (err, response, body) ->
    if err? or not body? then return res.sendStatus(500)
    else if response.statusCode is 403 or response.statusCode is 201
      res.status(201)
      res.send(body)
    else res.sendStatus(response.statusCode)

module.exports =
  get: get
  get_by_id: get_by_id
  post: post
