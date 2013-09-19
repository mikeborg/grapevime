App.controller 'SearchCtrl', ['$scope', 'Search', ($scope, Search) ->
  
  $scope.conversations = Search.query(() -> console.log $scope.conversations )
  
  $scope.closeComment = (comment) ->
    comment.comments.shift()
    
  $scope.activeComment = (comment) ->
    comment.comments[0]
    
]