module.exports =

  init: (router) ->

    available_appointments = require './routes/available_appointments'
    router.get '/api/coach/:coach_id/available-appointments/date/:date', available_appointments.get_by_date

    appointment = require './routes/appointment'
    router.get '/api/client/:client_id/appointment', appointment.get_by_client
    router.post '/api/appointment', appointment.post

    client = require './routes/client'
    router.get '/api/client/:id', client.get
    router.post '/api/client', client.post