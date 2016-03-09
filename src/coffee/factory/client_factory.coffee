window.factory ?= {}

window.factory.client ?= ['$http', ($http) ->

  client = {}

  update = (user) ->
    params =
      google_id: user.identity
      name: user.username
      email: user.email
      phone: '(123) 456-7890'

    $http.post('/api/client', params).then (result) ->
      $http.get(result.data).then (client_result) ->
        client.id = client_result.data.id
        client.name = client_result.data.name
        client.email = client_result.data.email
        client.phone = client_result.data.phone
        client.coach = client_result.data.coach

  get: -> client

  update: (user) -> update(user)
]