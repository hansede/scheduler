window.ctrl ?= {}

window.ctrl.phone_dialog ?= ['$scope', '$mdDialog', ($scope, $mdDialog) ->

  $scope.submit_phone = -> $mdDialog.hide($scope.phone)
]