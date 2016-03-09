angular.module('Scheduler', ['ngMaterial', 'ngAnimate', 'ngRoute', 'ngMessages'])

  .config(config.color)
  .config(config.router)

  .controller('AppointmentCtrl', ctrl.appointment)
  .controller('CoachPortalCtrl', ctrl.coach_portal)
  .controller('PhoneDialogCtrl', ctrl.phone_dialog)
  .controller('SchedulerCtrl', ctrl.scheduler)

  .factory('AppointmentFactory', factory.appointment)
  .factory('ClientFactory', factory.client)
  .factory('CoachFactory', factory.coach)