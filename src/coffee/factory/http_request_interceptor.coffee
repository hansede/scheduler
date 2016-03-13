window.factory ?= {}

window.factory.http_request_interceptor ?= [->
  request: (config) ->
    config.headers['Authorization'] = "Bearer #{window.id_token}"
    config
]