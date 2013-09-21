App.controller 'SearchCtrl', ['$scope', '$http', 'Search', ($scope, $http, Search) ->
  #how do I query with search parameters such as ?q=%23BostonBombing
  
  $scope.search = () ->
    console.log($scope.query)
    $http({
      method : 'GET'
      url : '/api/search/?q=' + $scope.query
    }).success((response) ->
      $scope.conversations = response
      )
    # $scope.conversations = Search.query(() -> console.log $scope.conversations )
]

App.controller 'SimpleCtrl', ['$scope', '$http', ($scope, $http) ->
  #primaryIndex parameter not necessary once $scope.conversations isn't reset with each call to $scope.closeComment()
  $scope.closeComment = (comment, parentComment, primaryIndex) ->
    if comment.comment_id == null
      alert primaryIndex
      #not working because $scope.conversations is being reset with each call to $scope.closeComment()
      $scope.conversations.splice(primaryIndex,1)
    else
      parentComment.comments.shift()
    
  $scope.activeComment = (comment) ->
    comment.comments[0]
    
  $scope.like = () ->
    $http({
      method : 'POST'
      url : '/comments/like'
    })
]