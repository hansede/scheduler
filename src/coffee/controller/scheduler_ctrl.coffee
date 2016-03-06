window.ctrl ?= {}

window.ctrl.scheduler ?= ['$scope', 'SchedulerFactory', ($scope, SchedulerFactory) ->

  $scope.username = window.profile.getName()
  $scope.avatar = window.profile.getImageUrl()
  $scope.client = SchedulerFactory.get_client()

  $scope.logout = ->
    auth2 = gapi.auth2.getAuthInstance()
    auth2.signOut().then -> window.location.reload()

  SchedulerFactory.update_client(window.id_token, $scope.username, window.profile.getEmail())
]