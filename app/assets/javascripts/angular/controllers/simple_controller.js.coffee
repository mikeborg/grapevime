App.controller 'SimpleCtrl', ['$scope', '$http', ($scope, $http) ->
  
  $scope.close = (comment, parentComment, primaryIndex) ->
    $http({
      method : 'PUT'
      url : '/comments/' + comment.id + '/close.json'
      data: {
        user_id : $scope.$root.currentUser.id
      }
    }).success((response) ->
      console.log("closed")
      if comment.comment_id == null
        $scope.conversations.splice(primaryIndex,1)
      else
        parentComment.comments.shift()
    )
    
  $scope.like = (comment) ->
    $http({
      method : 'PUT'
      url : '/comments/' + comment.id + '/like.json'
      data: {
        user_id : $scope.$root.currentUser.id
      }
    }).success((response) ->
      console.log("liked")
    )
    
  $scope.report = (comment) ->
    $http({
      method : 'PUT'
      url : '/comments/' + comment.id + '/report.json'
    }).success((response) ->
      console.log("reported")
    )
]