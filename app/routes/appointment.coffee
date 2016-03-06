request = require 'request'
env = require '../environment'

client_id = 'e9c615dc-d14c-4bce-9aab-0a0429eeb59d'
coach_id = 'c3bd93c3-e144-4783-9fc5-2a038f20ebf5'

module.exports =

  post: (req, res) ->
    params =
      form:
        client_id: client_id
        coach_id: coach_id
        appointment_date: req.body.appointment_date

    request.post "#{env.service_url}/api/appointment", params, (err, response, body) ->
      if err? or not body then return res.sendStatus(500)
      else return res.sendStatus(response.statusCode)