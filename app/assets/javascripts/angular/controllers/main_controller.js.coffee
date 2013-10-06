App.controller 'MainCtrl', ['$scope', '$rootScope', ($scope, $rootScope) ->
  console.log("MainCtrl")
  
  $scope.showNotice = () ->
    if $rootScope.notice
      true
    else
      false
      
  $scope.closeNotice = () ->
    $rootScope.notice = null
  ]