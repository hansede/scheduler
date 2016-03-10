module.exports =

  init: (router) ->

    available_appointments = require './routes/available_appointments'
    router.get '/api/coach/:coach_id/available-appointments/date/:date', available_appointments.get_by_date

    appointment = require './routes/appointment'
    router.get '/api/client/:client_id/appointment', appointment.get_by_client
    router.get '/api/coach/:coach_id/appointment', appointment.get_by_coach
    router.post '/api/appointment', appointment.post

    client = require './routes/client'
    router.get '/api/client/:id', client.get_by_id
    router.post '/api/client', client.post

    coach = require './routes/coach'
    router.get '/api/coach', coach.get
    router.get '/api/coach/:id', coach.get_by_id
    router.post '/api/coach', coach.post