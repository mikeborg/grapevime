App.factory 'Search', ['$resource', ($resource) ->
  $resource("/api/search")
]

App.factory "Comment", ["$resource", ($resource) ->
  $resource("/api/comments/:id", {id: "@id"}, {update: {method: "PUT"}})
]