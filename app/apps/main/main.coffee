angular.module 'app'
.controller 'MainCtrl', ($scope, $state, $rootScope, $location) ->
  $scope.nowUrl = $location.$$url
  console.log $location.$$url
  $rootScope.$on '$stateChangeStart', ->
    console.log 'changeStart'
  $rootScope.$on '$stateChangeSuccess', ->
    console.log 'changeSuccess'
    $scope.nowUrl = $location.$$url