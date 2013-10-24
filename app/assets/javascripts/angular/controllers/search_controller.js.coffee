App.controller 'SearchCtrl', ['$scope', '$http', 'Search', ($scope, $http, Search) ->
  console.log("SearchCtrl")
  #how do I query with search parameters such as ?q=%23BostonBombing
  
  $scope.search = () ->
    console.log("SearchCtrl -> Search()")
    $scope.searchResults = Search.save($scope.newSearch)
]