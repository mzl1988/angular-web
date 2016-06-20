angular.module 'app'
.controller 'WeclomeCtrl', ($scope, $stateParams, config) ->
  $scope.ui =
    email: '634390243@qq.comssssss'
    password: '123'
    checkMe: true
    users: [
        firstName: 'Mark'
        lastName: 'Otto'
        userName: '@mdo'
      ,
        firstName: 'Jacob'
        lastName: 'Thornton'
        userName: '@fat'
      ,
        firstName: 'Larry'
        lastName: 'the Bird'
        userName: '@twitter'
    ]

  $scope.delUser = (index) ->
    $scope.ui.users.splice index, 1

  $scope.addUser = ->
    option =
      firstName: "Mark#{$scope.ui.users.length}"
      lastName: "Otto#{$scope.ui.users.length}"
      userName: "@mdo#{$scope.ui.users.length}"
    $scope.ui.users.push option

  #交换数组元素
  swapItems = (index1, index2) ->
    $scope.ui.users[index1] = $scope.ui.users.splice(index2, 1, $scope.ui.users[index1])[0]

  # 上移
  $scope.upRecord = (index) ->
    swapItems(index, index - 1) if index isnt 0

  # 下移
  $scope.downRecord = (index) ->
    swapItems(index, index + 1) if index isnt ($scope.ui.users.length - 1)

  $scope.save = ->
    console.log $scope.ui

  $scope.saveUser = (user) ->
    console.log user
