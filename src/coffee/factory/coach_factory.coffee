window.factory ?= {}

window.factory.coach ?= ['$http', ($http) ->

  coach = {}

  update = (user) ->
    $http.get("/api/coach?email=#{user.email}").then (coach_result) ->
      coach.id = coach_result.id
      coach.name = coach_result.name
      coach.email = coach_result.email
      coach.phone = coach_result.phone
    , -> coach.id = ''

  save = (user) ->
    params =
      google_id: user.identity
      name: user.username
      email: user.email
      phone: user.phone
      avatar: user.avatar

    $http.post('/api/coach', params).then (result) ->
      $http.get(result.data).then (coach_result) ->
        coach.id = coach_result.id
        coach.name = coach_result.name
        coach.email = coach_result.email
        coach.phone = coach_result.phone
        coach.avatar = coach_result.avatar
        console.log 'success!'

  get: -> coach

  update: (user) -> update(user)

  save: (user) -> save(user)
]