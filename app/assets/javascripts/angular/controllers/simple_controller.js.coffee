App.controller 'SimpleCtrl', ['$rootScope', '$scope', '$http', 'Comment', 'flash', ($rootScope, $scope, $http, Comment, flash) ->  
  console.log("SimpleCtrl")
  $scope.liked = (comment) ->
    false
    
  $scope.loadComments = (comment) ->
    $http({
      method : 'GET'
      url : '/api/comments/' + comment.id + '/comments.json'
    }).success((response) ->
      console.log("Retrieved comments.")
      if response[0] != undefined
        comment.comments = []
        comment.comments.push(response[0])
    )
  
  $scope.lastChild = (comment) ->
    if comment.comments == undefined or comment.comments.length == 0
      true
    else
      false
  
  $scope.addComment = (parentComment) ->
    $scope.newComment.comment_id = parentComment.id
    comment = Comment.save($scope.newComment, () ->
      console.log("Comment submitted.")
      if parentComment.comments == undefined # for comment with no comments
        parentComment.comments = []
      parentComment.comments.unshift(comment)
      $scope.newComment = {}
      parentComment.slideVisible = false
      flash("Message saved.")
    )
    
    
    # $http(
    #   method: "POST"
    #   url: "/comments"
    #   data: {
    #     comment: {
    #       comment_id: parentComment.id
    #       message: $scope.newComment.message
    #     }
    #   }
    # ).success((data,status,headers,config) ->

    # console.log("Comment successfully submitted.")
    #       comment = Comment
    #       if parentComment.comments == undefined # for comment with no comments
    #         parentComment.comments = []
    #       parentComment.comments.unshift(comment)
    #       $scope.newComment = {}
    #       parentComment.slideVisible = false
    #     ).error (data,status,headers,config) ->
    #       console.log "Error adding comment."
    #       console.log status
    #       if(status == 401) #this needs to be in a error method
    #         $rootScope.notice = "You need to sign in through Twitter or Facebook to submit comments."
    #         console.log("Error: " + status)
    #       else if (status == 500)
    #         $rootScope.notice = "Sorry Something went wrong. Please try again."
    #       false
      

  
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
    }).success((response) ->
      console.log("closed.. fix .$parent.$parent thing.")
      if comment.comment_id == null # if primary comment
        $scope.$parent.$parent.conversations.splice(primaryIndex,1) #fix this .$parent.$parent thing... $rootScope?
        $scope.$parent.$parent.conversations.push(response)
      else
        parentComment.comments.shift()
        parentComment.comments.push(response)
    )
    
  $scope.vime = (comment) ->
    $http({
      method : 'PUT'
      url : '/api/comments/' + comment.id + '/vime.json'
    }).success((response) ->
      if(response.notice)  #this needs to be in a error method
        # $rootScope.notice = response.notice
        console.log("Comment: " + response.notice)
      else  #this needs to be in a success method
        console.log("Comment vimed.")
    )
  
  $scope.like = (comment) ->
    $http({
      method : 'PUT'
      url : '/api/comments/' + comment.id + '/like.json'
    }).success((response) ->
      console.log("Comment liked.")
    ).error((response) ->
      console.log("Error: " + response)
      if(response.notice)
        # $rootScope.notice = response.notice
        console.log("Comment: " + response.notice))
    
  $scope.report = (comment) ->
    $http({
      method : 'PUT'
      url : '/api/comments/' + comment.id + '/report.json'
    }).success((response) ->
      console.log("Comment reported.")
    ).error((response) ->
      console.log("Error: " + response)
      if(response.notice)  #this needs to be in an error method
        # $rootScope.notice = response.notice
        console.log("Comment: " + response.notice))
]