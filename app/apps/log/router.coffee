angular.module 'app'
.config ($stateProvider) ->
  $stateProvider
    .state 'app.log',
      url: '/log'
      templateUrl: 'apps/log/log'
      controller: 'LogCtrl'