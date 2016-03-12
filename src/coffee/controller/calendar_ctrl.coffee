window.ctrl ?= {}

window.ctrl.calendar ?= ['$scope', ($scope) ->

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
]