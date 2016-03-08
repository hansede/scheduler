angular.module('Scheduler', ['ngMaterial', 'ngAnimate'])

  .config(config.color)

  .controller('AppointmentCtrl', ctrl.appointment)
  .controller('SchedulerCtrl', ctrl.scheduler)

  .factory('AppointmentFactory', factory.appointment)
  .factory('SchedulerFactory', factory.scheduler)