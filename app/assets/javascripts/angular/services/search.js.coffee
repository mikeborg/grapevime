App.factory 'Search', ['$resource', ($resource) ->
  $resource("/api/search")
]
