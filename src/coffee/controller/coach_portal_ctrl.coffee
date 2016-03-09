window.ctrl ?= {}

window.ctrl.coach_portal ?= ['$scope', '$mdDialog', 'CoachFactory', ($scope, $mdDialog, CoachFactory) ->

  $scope.coach = CoachFactory.get()
  CoachFactory.update($scope.user)

  $scope.$watchCollection 'coach', (new_value) ->
    if new_value.id is ''
      $mdDialog.show(
        controller: 'PhoneDialogCtrl'
        templateUrl: '/html/template/phone_dialog.html'
        parent: angular.element(document.body)
        clickOutsideToClose: no
      ).then (phone) ->
        $scope.user.phone = phone
        CoachFactory.save($scope.user)
]