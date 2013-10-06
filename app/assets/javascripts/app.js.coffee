window.App = angular.module('Grapevime', ['ngResource'])

# App.config ($httpProvider) ->
#   authToken = $("meta[name=\"csrf-token\"]").attr("content")
#   $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken