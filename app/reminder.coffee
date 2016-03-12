nodemailer = require 'nodemailer'
jade = require 'jade'
sugar = require 'sugar'
env = require './environment'

transporter = nodemailer.createTransport("smtps://#{env.smtp_address}:#{env.smtp_password}@smtp.gmail.com")

send = (address, name, coach, date) ->
  template_vars =
    name: name
    coach: coach
    date: (new Date(date)).format()

  mailOptions =
    from: '"noreply" <noreplyfake123@gmail.com>'
    to: address
    subject: 'Your Upcoming Coaching Appointment'
    html: jade.compileFile('./templates/email/reminder.jade', {})(template_vars)
    attachments: [
      {
        filename: 'logo.png'
        path: './dist/img/logo.png'
        cid: 'arivale-logo'
      }
    ]

  transporter.sendMail mailOptions, (error, info) ->
    if error? then console.log(error)
    else console.log("Message sent: #{info.response}")

module.exports =
  send: send