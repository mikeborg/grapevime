App.directive "vime", ($compile) ->
  restrict: "E"
  controller: "SearchCtrl"
  scope:
    comment: "="
  template: "<div class='header'><a class='boxclose' ng-click=\"closeComment($parent.comment)\"></a></div>" +
            "<div class='body'>{{ comment.message }} {{comment.id}}</div>" +
            "<div class='footer'><img class='reply' src='/assets/reply-icon.png'></div>" +
            "<vime ng-repeat=\"child in comment.comments.slice(0,1)\" comment=\"child\"></vime>"
  compile: (tElement, tAttr) ->
    contents = tElement.contents().remove()
    compiledContents = undefined
    (scope, iElement, iAttr) ->
      compiledContents = $compile(contents)  unless compiledContents
      compiledContents scope, (clone, scope) ->
        iElement.append clone