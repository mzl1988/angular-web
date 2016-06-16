angular.module 'app'
.controller 'WeclomeCtrl', ($scope, $stateParams, config) ->
	$scope.ui =
		email: '634390243@qq.com'
		password: '123'
		checkMe: true

	$scope.save = ->
		console.log $scope.ui
