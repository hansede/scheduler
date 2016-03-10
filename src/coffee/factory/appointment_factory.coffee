window.factory ?= {}

window.factory.appointment ?= ['$http', ($http) ->

  available_times = []

  appointments = []

  update_available_times = (coach_id, date) ->
    available_times.length = 0

    $http.get("/api/coach/#{coach_id}/available-appointments/date/#{date.getTime()}").then (result) ->
      available_times.push.apply(available_times, result.data)

  update_appointments = (coach_id) ->
    $http.get("/api/coach/#{coach_id}/appointment").then (result) ->
      appointments.length = 0
      appointments.push.apply(appointments, result.data)

  get_available_times: -> available_times

  update_available_times: (coach_id, date) -> update_available_times(coach_id, date)

  get_appointment: (client_id) -> $http.get("/api/client/#{client_id}/appointment")

  get_appointments: -> appointments

  update_appointments: (coach_id) -> update_appointments(coach_id)

  submit: (appointment, client_id, coach_id) ->
    params =
      appointment_date: appointment
      client_id: client_id
      coach_id: coach_id

    $http.post '/api/appointment', params
]