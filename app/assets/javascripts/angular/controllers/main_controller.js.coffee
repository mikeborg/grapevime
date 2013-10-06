App.controller 'MainCtrl', ['$scope', '$rootScope', ($scope, $rootScope) ->
  #$rootScope.$watch('currentUser', ->
  console.log("MainCtrl")
  $scope.$watch 'currentUser', ->
    $rootScope.currentUser = $scope.currentUser
    console.log($rootScope.currentUser)
    console.log($scope.currentUser)
  ]