window.onSignIn = (googleUser) ->
  window.profile = googleUser.getBasicProfile()
  window.id_token = googleUser.getAuthResponse().id_token
  $('.login-area').hide()
  window.injector = angular.bootstrap($('body')[0], ['Scheduler'])

window.logout = ->
  auth2 = gapi.auth2.getAuthInstance()
  auth2.signOut().then ->
    window.location = "https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=#{window.location.href}"