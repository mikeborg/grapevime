App.directive "vime", ($compile) ->
  restrict: "E"
  controller: "SimpleCtrl"
  scope:
    comment: "="
    index: "="
  template: "<div class='header'>" +
              "<a><img src='/assets/bookmark-icon.png' class='bookmark' ng-click='bookmark(comment)'></a>" +
              "<a class='boxclose' ng-click=\"close(comment, $parent.comment, index)\"></a>" +
            "</div>" +
            "<div class='body'>{{ comment.message }}" +
            "</div>" +
            "<div class='footer'>" +
              "<img src='/assets/like-icon.png' class='like' ng-click='like(comment)' />" +
              "<img src='/assets/reply-icon.png' class='reply' ng-click='replySlide(comment)'>" +
              "<img src='/assets/menu-icon.png' class='menu' ng-click='menuSlide(comment)'>" +
            "</div>" +
            "<div class='slide' ng-show='comment.slideVisible'>" +
              "<div class='menu-slide' ng-show='showMenuSlide(comment)'>" +
                "<ul>" +
                  "<li><a ng-click='report(comment)'>Report as Abuse/Spam</a></li>" +
                  "<li><a>Comment Info</a></li>" +
                  "<li><a ng-show='lastChild(comment)' ng-click='loadComments(comment)'>More</a></li> " +
                "</ul>" +
              "</div>" +
              "<div class='reply-slide' ng-show='showReplySlide(comment)'>" +
                "<form ng-submit='addComment(comment)'>" +
                  "<textarea rows='6' cols='28' ng-model='newComment.message'></textarea>" +
                  "<input type='hidden' ng-model='newComment.comment_id'>" +
                  "<input style='margin-left:160px;' type='submit' value='Submit'>" +
                "</form>" +
              "</div>" +
            "</div>" +
            "<vime ng-repeat=\"child in comment.comments.slice(0,1)\"' comment=\"child\"></vime>"
  compile: (tElement, tAttr) ->
    contents = tElement.contents().remove()
    compiledContents = undefined
    (scope, iElement, iAttr) ->
      compiledContents = $compile(contents)  unless compiledContents
      compiledContents scope, (clone, scope) ->
        iElement.append clone