window.ctrl ?= {}

window.ctrl.client ?= ['$scope', '$mdDialog', '$timeout', 'AppointmentFactory', 'ClientFactory',
  ($scope, $mdDialog, $timeout, AppointmentFactory, ClientFactory) ->

    $scope.is_scheduled = no
    $scope.is_submitting = no
    $scope.appointments = AppointmentFactory.get()
    $scope.appointment_date = undefined
    $scope.appointment_time = undefined
    $scope.client = ClientFactory.get()
    ClientFactory.update($scope.user)

    show_cancellation_confirmation = ->
      $mdDialog.show(
        $mdDialog.confirm()
          .parent(angular.element(document.querySelector('body')))
          .clickOutsideToClose(yes)
          .title('Cancel your appointment')
          .textContent("Are you sure you want to cancel?")
          .ariaLabel('Cancellation Confirmation')
          .ok('Yes')
          .cancel('No')
      )

    show_cancellation_success = ->
      $mdDialog.show(
        $mdDialog.alert()
          .parent(angular.element(document.querySelector('body')))
          .clickOutsideToClose(yes)
          .title('Success')
          .textContent("Your appointment has been cancelled.")
          .ariaLabel('Cancellation Success Alert')
          .ok('Okay')
      )

    show_cancellation_failure = ->
      $mdDialog.show(
        $mdDialog.alert()
          .parent(angular.element(document.querySelector('body')))
          .clickOutsideToClose(yes)
          .title('Oops!')
          .textContent("We were unable to cancel your appointment, please try again.")
          .ariaLabel('Cancellation Failure Alert')
          .ok('Okay')
      )

    show_scheduling_success = ->
      $mdDialog.show(
        $mdDialog.alert()
          .parent(angular.element(document.querySelector('body')))
          .clickOutsideToClose(yes)
          .title('Success')
          .textContent("Your appointment has been scheduled.")
          .ariaLabel('Scheduling Success Alert')
          .ok('Okay')
      )

    show_scheduling_failure = ->
      $mdDialog.show(
        $mdDialog.alert()
          .parent(angular.element(document.querySelector('body')))
          .clickOutsideToClose(yes)
          .title('Oops!')
          .textContent('We were unable to create your appointment, please try again.')
          .ariaLabel('Scheduling Failure Alert')
          .ok('Okay')
      )

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

    $scope.cancel = ->
      show_cancellation_confirmation().then ->
        AppointmentFactory.cancel($scope.client.id).then ->
          show_cancellation_success().then -> $scope.reset()
        , ->
          show_cancellation_failure().then -> $scope.reset()

    $scope.submit = ->
      $scope.is_submitting = yes

      AppointmentFactory.submit($scope.appointment_time, $scope.client.id, $scope.client.coach.id).then ->
        $scope.is_submitting = no
        show_scheduling_success().then -> $scope.is_scheduled = yes
      , ->
        $scope.is_submitting = no
        show_scheduling_failure()
]