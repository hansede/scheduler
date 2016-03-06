angular.module('Scheduler', ['ngMaterial'])

  .config(config.color)

  .controller('AppointmentCtrl', ctrl.appointment)
  .controller('SchedulerCtrl', ctrl.scheduler)

  .factory('AppointmentFactory', factory.appointment)