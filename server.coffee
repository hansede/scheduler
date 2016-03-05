express = require 'express'
winston = require 'winston'
express_winston = require 'express-winston'

PORT = 9999

server = express()
router = express.Router()
server_root = '/'

router.all('*', (req, res, next) ->
  res.header("Access-Control-Allow-Origin", "*")
  res.header("Access-Control-Allow-Headers", "X-Requested-With")
  next()
)

router.use(express_winston.logger(transports: [new winston.transports.Console(json: yes)]))
router.use(express.static('dist'))

server.use server_root, router
server.listen(PORT)
console.log "Started server on #{PORT}"
