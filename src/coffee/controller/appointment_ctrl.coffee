window.ctrl ?= {}

window.ctrl.appointment ?= ['$scope', '$timeout', ($scope, $timeout) ->

  $scope.available_times = []

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
    console.log $scope.appointment_date
    $scope.available_times.length = 0
    $scope.appointment_time = undefined
    $scope.available_times.push('12:00pm')

  $scope.schedule = (time) ->
    $scope.appointment_time = time
    $timeout(-> $scope.$apply())

  $scope.reset = ->
    $scope.appointment_date = undefined
    $scope.appointment_time = undefined
    $scope.available_times.length = 0
]