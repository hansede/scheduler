window.config ?= {}

window.config.router ?= ['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: '/html/appointment.html'
      controller: 'AppointmentCtrl'
    .when '/coach',
      templateUrl: '/html/coach_portal.html'
      controller: 'CoachPortalCtrl'
    .otherwise redirectTo: '/'
]