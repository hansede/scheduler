module.exports =

  init: (router) ->

    available_appointments = require './routes/available_appointments'
    router.get '/api/available-appointments/date/:date', available_appointments.get_by_date

    appointment = require './routes/appointment'
    router.post '/api/appointment', appointment.post

    client = require './routes/client'
    router.get '/api/client/:id', client.get
    router.post '/api/client', client.post