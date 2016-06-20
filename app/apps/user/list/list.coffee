angular.module 'app'
.controller 'UserListCtrl', ($scope, $state) ->
  console.log 'user list'
  $scope.ui =
    totalItems: 64
    currentPage: 1

  logPage = ->
    console.log $scope.ui.currentPage
    
    # $http.get "url",
    #   params:
    #     pageNum: ''
    # .success (res) ->

    # .error (error) ->

    # $http.post "url", {pageNum: ''}
    # .success (res) ->

    # .error (error) ->


  $scope.$watch 'ui.currentPage', logPage


  $scope.goWeclome = ->
    $state.go 'app.weclome'


