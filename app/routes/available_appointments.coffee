request = require 'request'

service_url = 'http://localhost:9998'

START_TIME_HOURS = 9
DURATION_HOURS = 8

round_date = (time_stamp) ->
  time_stamp.setHours(0)
  time_stamp.setMinutes(0)
  time_stamp.setSeconds(0)
  time_stamp.setMilliseconds(0)
  time_stamp

module.exports =
  get_by_date: (req, res) ->
    date = round_date(new Date(parseInt(req.params.date)))

    request "#{service_url}/api/coach/#{req.params.coach_id}/appointment/date/#{date.getTime()}", (err, response, body) ->
      if err? or not body then return res.sendStatus(500)
      else if response.statusCode isnt 200 then return res.sendStatus(response.statusCode)

      appointments = JSON.parse(body)
      appointment_times = []
      available_times = []

      for appointment in appointments
        appointment_times.push((new Date(appointment.appointment_date)).getTime())

      for i in [0..(DURATION_HOURS - 1)]
        available_time = new Date(date)
        available_time.setHours(START_TIME_HOURS + i)

        if available_time.getTime() not in appointment_times
          available_times.push(available_time.getTime())

      res.send(available_times)