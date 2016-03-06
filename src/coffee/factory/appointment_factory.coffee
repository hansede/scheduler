window.factory ?= {}

window.factory.appointment ?= ['$http', ($http) ->

  available_times = []

  update_available_times = (date) ->
    available_times.length = 0

    $http.get("/api/available-appointments/date/#{date.getTime()}").success (data) ->
      available_times.push.apply(available_times, data)

  get_available_times: -> available_times

  update_available_times: (date) -> update_available_times(date)

  submit: (appointment) -> $http.post '/api/appointment', {appointment_date: appointment}
]