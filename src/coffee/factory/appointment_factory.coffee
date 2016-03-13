window.factory ?= {}

window.factory.appointment ?= ['$http', ($http) ->

  appointments =
    available: []
    scheduled: []
    none_available: no

  get = -> appointments

  get_appointment = (client_id) -> $http.get("/api/client/#{client_id}/appointment")

  update_available = (coach_id, date) ->
    appointments.available.length = 0

    $http.get("/api/coach/#{coach_id}/available-appointments?date=#{date.getTime()}").then (result) ->
      appointments.available.push.apply(appointments.available, result.data)
      appointments.none_available = result.data.length is 0

  update_scheduled = (coach_id) ->
    $http.get("/api/coach/#{coach_id}/appointment").then (result) ->
      appointments.scheduled.length = 0
      appointments.scheduled.push.apply(appointments.scheduled, result.data)

  submit = (appointment, client_id, coach_id) ->
    params =
      appointment_date: appointment
      client_id: client_id
      coach_id: coach_id

    $http.post '/api/appointment', params

  get: get
  get_appointment: get_appointment
  update_available: update_available
  update_scheduled: update_scheduled
  submit: submit
]