(function () {

  'use strict';

  var module = angular.module('inboxFilters', ['ngSanitize']);

  var getRelativeDate = function(date, format) {
    var m = moment(date);
    return '<span class="relative-date" title="' + m.format(format) + '">' + m.fromNow() + '</span>';
  };

  module.filter('relativeDate', ['RememberService',
    function (RememberService) {
      return function (date) {
        if (!date) { 
          return ''; 
        }
        return getRelativeDate(date, RememberService.dateFormat);
      };
    }
  ]);

  module.filter('state', ['RememberService',
    function (RememberService) {
      return function (task) {
        if (!task || !task.state) {
          return '';
        }
        var date = '';
        if (task.due) {
          date = '<br/>' + getRelativeDate(task.due, RememberService.dateFormat);
        }
        return '<span class="state">' + task.state + '</span>' + date;
      };
    }
  ]);

  var getFormName = function(message, forms) {
    for (var i = 0; i < forms.length; i++) {
      if (message.form === forms[i].code) {
        return forms[i].name;
      }
    }
    return message.form;
  };

  module.filter('summary', function () {
    return function (message, forms) {
      if (!message || !forms) { 
        return '';
      }
      if (message.form) {
        return getFormName(message, forms);
      }
      if (message.sms_message) {
        return message.sms_message.message;
      }
      if (message.tasks &&
          message.tasks[0] &&
          message.tasks[0].messages &&
          message.tasks[0].messages[0]) {
        return message.tasks[0].messages[0].message;
      }
      return 'Message';
    };
  });

  module.filter('title', function () {
    return function (message, forms) {
      if (!message || !forms) { 
        return '';
      }
      if (message.form) {
        return getFormName(message, forms);
      }
      if (message.kujua_message) {
        return 'Outgoing Message';
      }
      return 'Incoming Message';
    };
  });

  module.directive('scroller', ['$timeout', 'RememberService', 
    function($timeout, RememberService) {
      return {
        restrict: 'A',
        scope: {},
        link: function(scope, elm) {
          var raw = elm[0];
          
          elm.bind('scroll', function() {
            RememberService.scrollTop = raw.scrollTop;
          });

          $timeout(function() {
            raw.scrollTop = RememberService.scrollTop;
          });
        }
      };
    }
  ]);

  module.directive('mmSender', function() {
    return {
      restrict: 'E',
      scope: { message: '=' },
      templateUrl: '/partials/sender.html'
    };
  });

}());