App.directive "vime", ($compile) ->
  restrict: "E"
  controller: "SimpleCtrl"
  scope:
    comment: "="
    index: "="
  template: "<div class='header'>" +
              "<a><img src='/assets/vime-icon.png' class='vime' ng-click='vime(comment)'></a>" +
              "<a class='boxclose' ng-click=\"close(comment, $parent.comment, index)\"></a>" +
            "</div>" +
            "<div class='body'>{{ comment.message }}" +
            "</div>" +
            "<div class='footer'>" +
              "<img ng-src=\"{{liked(comment) == true && '/assets/thumb-icon-green.png' || '/assets/thumb-icon-gray.png'}}\" class='like' ng-click='like(comment)' />" +
              "<img ng-src=\"{{(showReplySlide(comment) && comment.slideVisible) && 'assets/reply-icon-green.png' || '/assets/reply-icon-gray.png'}}\" class='reply' ng-click='replySlide(comment)'>" +
              "<img ng-src=\"{{(showMenuSlide(comment) && comment.slideVisible) && 'assets/menu-icon-green.png' || '/assets/menu-icon-gray.png'}}\" class='menu' ng-click='menuSlide(comment)'>" +
            "</div>" +
            "<div class='slide' ng-show='comment.slideVisible'>" +
              "<div class='menu-slide' ng-show='showMenuSlide(comment)'>" +
                "<ul>" +
                  "<li><a ng-click='report(comment)'>Report as Abuse/Spam</a></li>" +
                  "<li><a>Comment Info</a></li>" +
                "</ul>" +
              "</div>" +
              "<div class='reply-slide' ng-show='showReplySlide(comment)'>" +
                "<form ng-submit='addComment(comment)'>" +
                  "<textarea rows='6' cols='28' ng-model='newComment.message'></textarea>" +
                  "<input style='margin-left:5px;' type='checkbox' ng-model='newComment.postTwitter'>Twitter" +
                  "<input type='hidden' ng-model='newComment.comment_id'>" +
                  "<input style='margin-left:90px;' type='submit' value='Submit'>" +
                "</form>" +
              "</div>" +
            "</div>" +
            "<div class='more' ng-show='lastChild(comment)' ng-click='loadComments(comment)' ><a>More</a></div>" +
            "<vime ng-repeat=\"child in comment.comments.slice(0,1)\"' comment=\"child\"></vime>"
  compile: (tElement, tAttr) ->
    contents = tElement.contents().remove()
    compiledContents = undefined
    (scope, iElement, iAttr) ->
      compiledContents = $compile(contents)  unless compiledContents
      compiledContents scope, (clone, scope) ->
        iElement.append clone