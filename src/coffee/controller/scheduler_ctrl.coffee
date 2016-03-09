window.ctrl ?= {}

window.ctrl.scheduler ?= ['$scope', ($scope) ->

  $scope.user =
    username: window.profile.getName()
    first_name: window.profile.getGivenName()
    avatar: window.profile.getImageUrl()
    identity: window.id_token
    email: window.profile.getEmail()

  $scope.logout = ->
    auth2 = gapi.auth2.getAuthInstance()
    auth2.signOut().then -> window.location.reload()
]