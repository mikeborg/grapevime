App.controller "SessionsController", ($scope, Session) ->
  $scope.session = Session.userSession
 
  $scope.create = ->
    if Session.signedOut
      $scope.session.$save().then ((response) ->
        $scope.$emit('event:loginConfirmed', response.data)
      ), (error) ->
 
  $scope.destroy = ->
    $scope.session.$destroy()
    $scope.$emit('event:logoutConfirmed')