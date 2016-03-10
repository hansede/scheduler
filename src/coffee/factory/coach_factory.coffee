window.factory ?= {}

window.factory.coach ?= ['$http', '$q', ($http, $q) ->

  coach = {}

  update = (user) ->
    deferred = $q.defer()

    $http.get("/api/coach?email=#{user.email}").then (coach_result) ->
      coach.id = coach_result.data.id
      coach.name = coach_result.data.name
      coach.email = coach_result.data.email
      coach.phone = coach_result.data.phone
      deferred.resolve()
    , -> deferred.reject()

    deferred.promise

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