App.directive "vime", ($compile) ->
  restrict: "E"
  controller: "SimpleCtrl"
  scope:
    comment: "="
    index: "="
    conversations: "="
  template: "<div class='header'><a class='boxclose' ng-click=\"close(comment, $parent.comment, index)\"></a></div>" +
            "<div class='body'>{{ comment.message }}</div>" +
            "<div class='footer'>" +
              "<img src='/assets/like-icon.png' class='like' ng-click='like(comment)' />" +
              "<img src='/assets/reply-icon.png' class='reply' ng-click='replySlide(comment)'>" +
              "<img src='/assets/menu-icon.png' class='menu' ng-click='menuSlide(comment)'></div>" +
            "<div class='slide' ng-show='comment.slideVisible'>" +
              "<div ng-show='showMenuSlide(comment)'>Menu!</div>" +
              "<div ng-show='showReplySlide(comment)'>Comment!</div></div>" +
            "<vime ng-repeat=\"child in comment.comments.slice(0,1)\"' comment=\"child\"></vime>"
  compile: (tElement, tAttr) ->
    contents = tElement.contents().remove()
    compiledContents = undefined
    (scope, iElement, iAttr) ->
      compiledContents = $compile(contents)  unless compiledContents
      compiledContents scope, (clone, scope) ->
        iElement.append clone