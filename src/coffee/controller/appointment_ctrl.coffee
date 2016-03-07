window.ctrl ?= {}

window.ctrl.appointment ?= ['$scope', '$mdDialog', '$timeout', 'AppointmentFactory',
  ($scope, $mdDialog, $timeout, AppointmentFactory) ->

    $scope.is_scheduled = no
    $scope.submitting = no
    $scope.available_times = AppointmentFactory.get_available_times()
    $scope.appointment_date = undefined
    $scope.appointment_time = undefined
    today = new Date()

    $scope.$watch '$parent.client.id', (new_value) ->
      if new_value? and new_value.length
        AppointmentFactory.get_appointment(new_value).then (result) ->
          $scope.is_scheduled = yes
          $scope.appointment_time = new Date(result.data.appointment_date)

    $scope.min_date = new Date(
      today.getFullYear(),
      today.getMonth(),
      today.getDate())

    $scope.max_date = new Date(
      today.getFullYear(),
      today.getMonth() + 1,
      today.getDate())

    $scope.weekdays_filter = (date) ->
      day = date.getDay()
      day isnt 0 and day isnt 6

    $scope.on_calendar_change = ->
      $scope.appointment_time = undefined
      AppointmentFactory.update_available_times($scope.appointment_date)

    $scope.schedule = (time) -> $scope.appointment_time = time

    $scope.reset = ->
      $scope.appointment_date = undefined
      $scope.appointment_time = undefined
      $scope.available_times.length = 0
      $scope.is_scheduled = no
      $timeout(-> $scope.$apply())

    $scope.submit = ->
      $scope.submitting = yes

      AppointmentFactory.submit($scope.appointment_time, $scope.$parent.client.id, $scope.$parent.client.coach.id).then((->
        $scope.submitting = no

        $mdDialog.show(
          $mdDialog.alert()
            .parent(angular.element(document.querySelector('body')))
            .clickOutsideToClose(yes)
            .title('Success')
            .textContent("Your appointment has been scheduled.")
            .ariaLabel('Success Alert')
            .ok('Okay')
        ).then -> $scope.is_scheduled = yes

      ), (->
        $scope.submitting = no

        $mdDialog.alert()
          .parent(angular.element(document.querySelector('body')))
          .clickOutsideToClose(yes)
          .title('Uh oh!')
          .textContent('We were unable to create your appointment, please try again.')
          .ariaLabel('Error Alert')
          .ok('Okay')
      ))
]