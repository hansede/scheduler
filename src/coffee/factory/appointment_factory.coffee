window.factory ?= {}

window.factory.appointment ?= ['$http', ($http) ->

  available_times = []

  update_available_times = (coach_id, date) ->
    available_times.length = 0

    $http.get("/api/coach/#{coach_id}/available-appointments/date/#{date.getTime()}").success (data) ->
      available_times.push.apply(available_times, data)

  get_available_times: -> available_times

  update_available_times: (coach_id, date) -> update_available_times(coach_id, date)

  get_appointment: (client_id) -> $http.get("/api/client/#{client_id}/appointment")

  submit: (appointment, client_id, coach_id) ->
    params =
      appointment_date: appointment
      client_id: client_id
      coach_id: coach_id

    $http.post '/api/appointment', params
]