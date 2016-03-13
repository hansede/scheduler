nodemailer = require 'nodemailer'
jade = require 'jade'
sugar = require 'sugar'
ical_event = require 'icalevent'
env = require './environment'

transporter = nodemailer.createTransport("smtps://#{env.smtp_address}:#{env.smtp_password}@smtp.gmail.com")

send = (client, coach, date) ->
  template_vars =
    name: client.name
    coach: coach.name

  mailOptions =
    from: '"noreply" <noreplyfake123@gmail.com>'
    to: client.email
    subject: 'Your Upcoming Coaching Appointment'
    html: jade.compileFile('./templates/email/reminder.jade', {})(template_vars)
    attachments: [
      {
        filename: 'logo.png'
        path: './dist/img/logo.png'
        cid: 'arivale-logo'
      }
    ]
    icalEvent:
      method: 'request'
      content: create_ical_event(client, coach, date)

  transporter.sendMail mailOptions, (error, info) ->
    if error? then console.log(error)
    else console.log("Message sent: #{info.response}")

create_ical_event = (client, coach, date) ->
  event_date = new Date(date)

  event = new ical_event(
    offset: (new Date).getTimezoneOffset()
    method: 'request'
    status: 'confirmed'
    attendees: [
      {
        name: client.name
        email: client.email
      }
      {
        name: coach.name
        email: coach.email
      }
    ]
    start: event_date
    end: event_date.setHours(event_date.getHours() + 1)
    timezone: 'US/Pacific'
    summary: 'Arivale Coaching Session'
    description: 'A coaching appointment to go over your wellness plan.'
    organizer:
      name: coach.name
      email: coach.email
  )

  event.toFile()

module.exports =
  send: send