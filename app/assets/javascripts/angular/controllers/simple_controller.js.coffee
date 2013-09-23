App.controller 'SimpleCtrl', ['$scope', '$http', ($scope, $http) ->  
  
  $scope.menuSlide = (comment) ->
    if comment.slideSelect == "menu"
      comment.slideVisible = not comment.slideVisible
    else
      comment.slideVisible = true
      comment.slideSelect = "menu"
    
  
  $scope.showMenuSlide = (comment) ->
    comment.slideSelect == "menu"
    
  $scope.replySlide = (comment) ->
    if comment.slideSelect == "reply"
      comment.slideVisible = not comment.slideVisible
    else
      comment.slideVisible = true
      comment.slideSelect = "reply"

  
  $scope.showReplySlide = (comment) ->
    comment.slideSelect == "reply"
  
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