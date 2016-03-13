angular.module('Scheduler', ['ngMaterial', 'ngAnimate', 'ngRoute', 'ngMessages'])

  .config(config.color)
  .config(config.http)
  .config(config.router)

  .controller('CalendarCtrl', ctrl.calendar)
  .controller('ClientCtrl', ctrl.client)
  .controller('CoachCtrl', ctrl.coach)
  .controller('PhoneDialogCtrl', ctrl.phone_dialog)
  .controller('SchedulerCtrl', ctrl.scheduler)

  .factory('AppointmentFactory', factory.appointment)
  .factory('ClientFactory', factory.client)
  .factory('CoachFactory', factory.coach)
  .factory('httpRequestInterceptor', factory.http_request_interceptor)