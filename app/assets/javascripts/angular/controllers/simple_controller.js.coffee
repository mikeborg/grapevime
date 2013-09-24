App.controller 'SimpleCtrl', ['$scope', '$http', 'Comment', ($scope, $http, Comment) ->  
  
  $scope.addComment = (parentComment) ->
      $scope.newComment.comment_id = parentComment.id
      comment = Comment.save($scope.newComment)
      console.log(comment)
      if parentComment.comments == undefined # for comment with no comments
        parentComment.comments = []
      parentComment.comments.unshift(comment)
      $scope.newComment = {}
      parentComment.slideVisible = false
  
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
      url : '/api/comments/' + comment.id + '/close.json'
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
    
  $scope.bookmark = (comment) ->
    $http({
      method : 'PUT'
      url : '/api/comments/' + comment.id + '/bookmark.json'
      data: {
        user_id : $scope.$root.currentUser.id
      }
    }).success((response) ->
      console.log("bookmarked")
    )
  
  $scope.like = (comment) ->
    $http({
      method : 'PUT'
      url : '/api/comments/' + comment.id + '/like.json'
      data: {
        user_id : $scope.$root.currentUser.id
      }
    }).success((response) ->
      console.log("liked")
    )
    
  $scope.report = (comment) ->
    $http({
      method : 'PUT'
      url : '/api/comments/' + comment.id + '/report.json'
      data: {
        user_id : $scope.$root.currentUser.id
      }
    }).success((response) ->
      console.log("reported")
    )
]