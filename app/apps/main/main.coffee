angular.module 'app'
.controller 'MainCtrl', ($scope, $state, $rootScope, $location) ->
  $scope.nowUrl = $location.$$url

  $rootScope.$on '$stateChangeStart', ->
  $rootScope.$on '$stateChangeSuccess', ->
    $scope.nowUrl = $location.$$url