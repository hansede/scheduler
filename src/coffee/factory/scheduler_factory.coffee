window.factory ?= {}

window.factory.scheduler ?= ['$http', ($http) ->

  client =
    id: ''
    name: ''
    email: ''
    phone: ''
    coach: {}

  update_client = (identity, username, email) ->
    params =
      google_id: identity
      name: username
      email: email
      phone: '(123) 456-7890'

    $http.post('/api/client', params).then (result) ->
      $http.get(result.data).then (client_result) ->
        client.id = client_result.data.id
        client.name = client_result.data.name
        client.email = client_result.data.email
        client.phone = client_result.data.phone
        client.coach = client_result.data.coach

  get_client: -> client

  update_client: (identity, username, email) -> update_client(identity, username, email)
]