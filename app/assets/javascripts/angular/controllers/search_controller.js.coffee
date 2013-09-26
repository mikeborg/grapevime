App.controller 'SearchCtrl', ['$scope', '$http', 'Search', ($scope, $http, Search) ->
  #how do I query with search parameters such as ?q=%23BostonBombing
  
  $scope.search = () ->
    console.log($scope.query)
    $http({
      method : 'GET'
      url : '/api/search/?q=' + $scope.query
    }).success((response) ->
      $scope.conversations = response
      console.log($scope.conversations)
      )
]