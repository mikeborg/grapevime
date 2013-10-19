angular.module('Grapevime.service', [])

window.App = angular.module('Grapevime', ['ngResource', 'Grapevime.service', 'flash', 'http-auth-interceptor'])
    
App.run(['$rootScope', '$http', 'flash', (scope, $http, flash) ->
  # initializers
  scope.$on "event:auth-loginRequired", ->
    scope.loggedIn = false
    flash("Please log in through Facebook or Twitter.")
    #Only redirect if we aren't on create or login pages.
    #return  if $location.path() is "/create" or $location.path() is "/login"
    # scope.pageWhen401 = $location.path()
    return
    #go to the login page
    # $location.path("/login").replace()
])

# App.config ($httpProvider) ->
#   authToken = $("meta[name=\"csrf-token\"]").attr("content")
#   $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken