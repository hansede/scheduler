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

    $http.post('/api/client', params).then (response) ->
      $http.get(response.data).then (client_response) ->
        $.extend(client, client_response.data)

    , (response) ->
      if response.status is 401 then window.logout()


  get: get
  update: update
]