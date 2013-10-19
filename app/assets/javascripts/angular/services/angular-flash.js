angular.module('flash', [])
.factory('flash', ['$rootScope', '$timeout', function($rootScope, $timeout) {
  var messages = [];

  var reset;
  var cleanup = function() {
    console.log("cleanup");
    $timeout.cancel(reset);
    reset = $timeout(function() { messages = []; });
  };

  var emit = function() {
    console.log("emit");
    $rootScope.$emit('flash:message', messages, cleanup);
  };

  $rootScope.$on('$locationChangeSuccess', emit);

  var asMessage = function(level, text) {
    console.log("asMessage");
    if (!text) {
      text = level;
      level = 'success';
    }
    return { level: level, text: text };
  };

  var asArrayOfMessages = function(level, text) {
    console.log("asArrayOfMessages");
    if (level instanceof Array) return level.map(function(message) {
      return message.text ? message : asMessage(message);
    });
    return text ? [{ level: level, text: text }] : [asMessage(level)];
  };

  var flash = function(level, text) {
    console.log("flash");
    emit(messages = asArrayOfMessages(level, text));
  };
  
  ['error', 'warning', 'info', 'success'].forEach(function (level) {
    flash[level] = function (text) { flash(level, text); };
  });
  
  return flash;
    
}])

.directive('flashMessages', [function() {
  var directive = { restrict: 'EA', replace: true };
  directive.template =
    '<ol id="flash-messages">' +
      '<li ng-repeat="m in messages" class="{{m.level}}">{{m.text}}</li>' +
      '<a ng-show=\'messages.length > 0\' ng-click=\'cleanupFlash()\'>Close</a>' +
    '</ol>';

  directive.controller = function($scope, $rootScope) {
    $rootScope.$on('flash:message', function(_, messages, done) {
      $scope.messages = messages;
      done();
    });
  };

  return directive;
}]);