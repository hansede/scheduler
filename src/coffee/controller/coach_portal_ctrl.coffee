window.ctrl ?= {}

window.ctrl.coach_portal ?= ['$scope', '$mdDialog', 'CoachFactory', 'AppointmentFactory',
  ($scope, $mdDialog, CoachFactory, AppointmentFactory) ->

    $scope.appointments = AppointmentFactory.get_appointments()
    $scope.coach = CoachFactory.get()

    CoachFactory.update($scope.user).then ->
      AppointmentFactory.update_appointments($scope.coach.id)
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