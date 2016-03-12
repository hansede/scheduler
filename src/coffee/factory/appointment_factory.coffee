window.factory ?= {}

window.factory.appointment ?= ['$http', ($http) ->

  available_times = []
  appointments = []

  get_available_times = -> available_times

  get_appointments = -> appointments

  update_available_times = (coach_id, date) ->
    available_times.length = 0

    $http.get("/api/coach/#{coach_id}/available-appointments/date/#{date.getTime()}").then (result) ->
      available_times.push.apply(available_times, result.data)

  update_appointments = (coach_id) ->
    $http.get("/api/coach/#{coach_id}/appointment").then (result) ->
      appointments.length = 0
      appointments.push.apply(appointments, result.data)

  get_appointment = (client_id) -> $http.get("/api/client/#{client_id}/appointment")

  submit = (appointment, client_id, coach_id) ->
    params =
      appointment_date: appointment
      client_id: client_id
      coach_id: coach_id

    $http.post '/api/appointment', params

  get_available_times: get_available_times
  update_available_times: update_available_times
  get_appointment: get_appointment
  get_appointments: get_appointments
  update_appointments: update_appointments
  submit: submit
]