App.factory "Comment", ["$resource", ($resource) ->
  $resource("/api/comments/:id.json", {id: "@id"}, {update: {method: "PUT"}})
]