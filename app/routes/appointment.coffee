request = require 'request'
env = require '../environment'

module.exports =

  post: (req, res) ->
    params =
      form:
        client_id: req.body.client_id
        coach_id: req.body.coach_id
        appointment_date: req.body.appointment_date

    request.post "#{env.service_url}/api/appointment", params, (err, response, body) ->
      if err? or not body then return res.sendStatus(500)
      else return res.sendStatus(response.statusCode)