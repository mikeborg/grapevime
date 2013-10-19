App.controller 'MainCtrl', ['$scope', '$rootScope', '$http', 'authService', 'flash', ($scope, $rootScope, $http, authService, flash) ->
  console.log("MainCtrl")
  
  $scope.loggedIn = () ->
    authService.loginConfirmed()
    $rootScope.loggedIn = true
    console.log("Login Confirmed.")
    
  $scope.cleanupFlash = () ->
    flash("AHHHH!")
  ]