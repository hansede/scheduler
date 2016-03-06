angular.module('Scheduler', ['ngMaterial'])

  .controller('AppointmentCtrl', ctrl.appointment)
  .controller('SchedulerCtrl', ctrl.scheduler)

  .factory('AppointmentFactory', factory.appointment)