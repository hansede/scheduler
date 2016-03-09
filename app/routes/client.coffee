request = require 'request'
env = require '../environment'

get_random_int = (min, max) -> (Math.floor(Math.random() * (max - min + 1)) + min)

module.exports =

  get_by_id: (req, res) ->
    request "#{env.service_url}/api/client/#{req.params.id}", (err, response, body) ->
      if err? or not body? then return res.sendStatus(500)
      else if response.statusCode isnt 200 then return res.sendStatus(response.statusCode)
      else
        client = JSON.parse(body)

        request "#{env.service_url}/api/coach/#{client.coach_id}", (err, response, body) ->
          if err? or not body? then return res.sendStatus(500)
          else if response.statusCode isnt 200 then return res.sendStatus(response.statusCode)
          else
            coach = JSON.parse(body)
            client.coach = coach
            delete client['coach_id']
            res.send(client)

  post: (req, res) ->

    params =
      form:
        google_id: req.body.google_id
        name: req.body.name
        email: req.body.email
        phone: req.body.phone

    request.post "#{env.service_url}/api/client", params, (err, response, body) ->
      client_body = body

      if err? or not body? then return res.sendStatus(500)

      else if response.statusCode is 403
        res.status(201)
        res.send(body)

      else if response.statusCode is 201
        client_id = body.split('/').pop()

        # Get coaches and assign a coach
        request "#{env.service_url}/api/coach", (err, response, body) ->
          if err? or not body? then return res.sendStatus(500)
          else
            coaches = JSON.parse(body)
            if not coaches.length then return res.sendStatus(500)
            coach = coaches[get_random_int(0, coaches.length - 1)] # Randomly assign a coach
            params = form: client_id: client_id

            request.post "#{env.service_url}/api/coach/#{coach.id}/client", params, (err, response, body) ->
              if err? then return res.sendStatus(500)
              else if response.statusCode isnt 201 then return res.sendStatus(response.statusCode)
              else
                res.status(201)
                res.send(client_body)

      else res.sendStatus(response.statusCode)
