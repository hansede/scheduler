window.onSignIn = (googleUser) ->
  window.profile = googleUser.getBasicProfile()
  window.id_token = googleUser.getAuthResponse().id_token
  $('.login-area').hide()
  window.injector = angular.bootstrap($('body')[0], ['Scheduler'])