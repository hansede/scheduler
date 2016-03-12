window.ctrl ?= {}

window.ctrl.client ?= ['$scope', '$mdDialog', '$timeout', 'AppointmentFactory', 'ClientFactory',
  ($scope, $mdDialog, $timeout, AppointmentFactory, ClientFactory) ->

    $scope.client = ClientFactory.get()
    $scope.is_scheduled = no
    $scope.is_submitting = no
    $scope.appointments = AppointmentFactory.get()
    $scope.appointment_date = undefined
    $scope.appointment_time = undefined
    ClientFactory.update($scope.user)

    $scope.$watch 'client.id', (new_value) ->
      if new_value? and new_value.length
        AppointmentFactory.get_appointment(new_value).then (result) ->
          $scope.is_scheduled = yes
          $scope.appointment_time = new Date(result.data.appointment_date)

    $scope.on_calendar_change = ->
      $scope.appointment_time = undefined
      AppointmentFactory.update_available($scope.client.coach.id, $scope.appointment_date)

    $scope.schedule = (time) -> $scope.appointment_time = time

    $scope.reset = ->
      $scope.appointment_date = undefined
      $scope.appointment_time = undefined
      $scope.appointments.available.length = 0
      $scope.is_scheduled = no
      $timeout(-> $scope.$apply())

    $scope.submit = ->
      $scope.is_submitting = yes

      AppointmentFactory.submit($scope.appointment_time, $scope.client.id, $scope.client.coach.id).then ->
        $scope.is_submitting = no

        $mdDialog.show(
          $mdDialog.alert()
            .parent(angular.element(document.querySelector('body')))
            .clickOutsideToClose(yes)
            .title('Success')
            .textContent("Your appointment has been scheduled.")
            .ariaLabel('Success Alert')
            .ok('Okay')
        ).then -> $scope.is_scheduled = yes

      , ->
        $scope.is_submitting = no

        $mdDialog.show(
          $mdDialog.alert()
            .parent(angular.element(document.querySelector('body')))
            .clickOutsideToClose(yes)
            .title('Oops!')
            .textContent('We were unable to create your appointment, please try again.')
            .ariaLabel('Error Alert')
            .ok('Okay')
        )
]