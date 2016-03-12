window.factory ?= {}

window.factory.client ?= ['$http', ($http) ->

  client = {}

  get = -> client

  update = (user) ->
    params =
      google_id: user.identity
      name: user.username
      email: user.email
      avatar: user.avatar

    $http.post('/api/client', params).then (result) ->
      $http.get(result.data).then (client_result) ->
        $.extend(client, client_result.data)

  get: get
  update: update
]