request = require 'request'
env = require '../environment'
Q = require 'q'

module.exports =

  get_by_client: (req, res) ->
    request "#{env.service_url}/api/client/#{req.params.client_id}/appointment", (err, response, body) ->
      if err? or not body? then return res.sendStatus(500)
      else if response.statusCode isnt 200 then return res.sendStatus(response.statusCode)
      else return res.send(JSON.parse(body))

  get_by_coach: (req, res) ->
    request "#{env.service_url}/api/coach/#{req.params.coach_id}/appointment", (err, response, body) ->
      debugger
      if err? or not body? then return res.sendStatus(500)
      else if response.statusCode isnt 200 then return res.sendStatus(response.statusCode)
      else
        json = JSON.parse(body)
        promises = []

        for appointment in json
          promises.push new Promise (resolve, reject) ->
            request "#{env.service_url}/api/client/#{appointment.client_id}", (err, response, body) ->
              if err? or not body? or res.statusCode isnt 200
                reject(new Error('Could not get client'))
              else
                client = JSON.parse(body)

                for appt in json
                  if appt.client_id is client.id
                    delete appt.client_id
                    appt.client = client
                    resolve()
                    break

        Q.all(promises).then -> res.send(json)
        .fail -> res.sendStatus(500)

  post: (req, res) ->
    params =
      form:
        client_id: req.body.client_id
        coach_id: req.body.coach_id
        appointment_date: req.body.appointment_date

    request.post "#{env.service_url}/api/appointment", params, (err, response, body) ->
      if err? or not body? then return res.sendStatus(500)
      else return res.sendStatus(response.statusCode)