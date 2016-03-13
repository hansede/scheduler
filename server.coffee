express = require 'express'
winston = require 'winston'
express_winston = require 'express-winston'
body_parser = require 'body-parser'
api = require './app/api'
authentication = require './app/authentication.coffee'

PORT = 9999

server = express()
server.use(body_parser.json())
server.use(body_parser.urlencoded(extended: yes))
router = express.Router()
server_root = '/'

router.use(express_winston.logger(transports: [new winston.transports.Console(json: yes)]))

authentication.init(router)
api.init(router)
router.use(express.static('dist'))

server.use server_root, router
server.listen(PORT)
console.log "Started server on #{PORT}"
