window.config ?= {}

window.config.router ?= ['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when '/client',
      templateUrl: '/html/page/client.html'
      controller: 'ClientCtrl'
    .when '/coach',
      templateUrl: '/html/page/coach.html'
      controller: 'CoachCtrl'
    .otherwise redirectTo: '/client'
]