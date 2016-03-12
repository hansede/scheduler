window.ctrl ?= {}

window.ctrl.coach ?= ['$scope', '$mdDialog', 'CoachFactory', 'AppointmentFactory',
  ($scope, $mdDialog, CoachFactory, AppointmentFactory) ->

    $scope.appointments = AppointmentFactory.get()
    $scope.coach = CoachFactory.get()

    CoachFactory.update($scope.user).then ->
      AppointmentFactory.update_scheduled($scope.coach.id)
    , ->
      $mdDialog.show(
        controller: 'PhoneDialogCtrl'
        templateUrl: '/html/template/phone_dialog.html'
        parent: angular.element(document.body)
        clickOutsideToClose: no
      ).then (phone) ->
        $scope.user.phone = phone
        CoachFactory.save($scope.user)
]