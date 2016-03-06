window.ctrl ?= {}

window.ctrl.appointment ?= ['$scope', '$mdDialog', '$timeout', '$filter', 'AppointmentFactory',
  ($scope, $mdDialog, $timeout, $filter, AppointmentFactory) ->

    $scope.submitting = no
    $scope.available_times = AppointmentFactory.get_available_times()
    $scope.appointment_date = undefined
    $scope.appointment_time = undefined
    today = new Date()

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
      $timeout(-> $scope.$apply())

    $scope.submit = ->
      $scope.submitting = yes

      AppointmentFactory.submit($scope.appointment_time).then ->
        $scope.submitting = no
        formatted_date = $filter('date')($scope.appointment_date, 'fullDate')
        formatted_time = $filter('date')($scope.appointment_time, 'h:mm a')

        $mdDialog.show(
          $mdDialog.alert()
            .parent(angular.element(document.querySelector('body')))
            .clickOutsideToClose(yes)
            .title('Success!')
            .textContent("Your appointment has been scheduled for #{formatted_date} @ #{formatted_time}")
            .ariaLabel('Success Alert')
            .ok('Got it!')
        ).then -> $scope.reset()

      , ->
        $scope.submitting = no

        $mdDialog.alert()
          .parent(angular.element(document.querySelector('body')))
          .clickOutsideToClose(yes)
          .title('Uh oh!')
          .textContent('We were unable to create your appointment, please try again.')
          .ariaLabel('Error Alert')
          .ok('Will do!')
]