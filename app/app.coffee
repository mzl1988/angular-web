angular.module 'app', [
  'ui.bootstrap'
  'ui.router'
  'ngAnimate'
]

.config ($stateProvider, $urlRouterProvider) ->

  $stateProvider
    .state 'app',
      url: ''
      abstract: true
      templateUrl: 'apps/main/main'
      controller: 'MainCtrl'

    .state 'app.weclome',
      url: '/weclome'
      templateUrl: 'apps/weclome/weclome'
      controller: 'WeclomeCtrl'

  $urlRouterProvider.otherwise("/weclome")



