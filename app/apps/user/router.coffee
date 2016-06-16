angular.module 'app'
.config ($stateProvider) ->
  $stateProvider
    .state 'app.user-list',
      url: '/user-list'
      templateUrl: 'apps/user/list/list'
      controller: 'UserListCtrl'