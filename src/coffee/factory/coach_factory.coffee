window.factory ?= {}

window.factory.coach ?= ['$http', '$q', ($http, $q) ->

  coach = {}

  get = -> coach

  update = (user) ->
    deferred = $q.defer()

    $http.get("/api/coach?email=#{user.email}").then (result) ->
      $.extend(coach, result.data)
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
        $.extend(coach, coach_result.data)

    , (response) ->
      if response.status is 401 then window.logout()

  get: get
  update: update
  save: save
]