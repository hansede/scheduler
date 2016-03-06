window.factory ?= {}

window.factory.scheduler ?= ['$http', ($http) ->

  client =
    id: ''

  update_client = (identity, username, email) ->
    params =
      google_id: identity
      name: username
      email: email
      phone: '(123) 456-7890'

    $http.post('/api/client', params).then (result) ->
      $http.get(result.data).then (client_result) ->
        client.id = client_result.data.id

  get_client: -> client

  update_client: (identity, username, email) -> update_client(identity, username, email)
]