(function(angular) {
  "use strict";
  
  angular
    .module('choiceApp', [])
    .controller('Controller', ['$scope', function($scope) {
      var One = "First";
      
      var Two = "Second";
      
      var Three = "Third";
        
      $scope.formData = {};
      
      $scope.$watch("formData.displayOption", function(displayOption) {
        if(displayOption) {
          var value1 = displayOption.firstChoice,
              value2 = displayOption.secondChoice,
              value3 = displayOption.thirdChoice;
          
          $scope.message = null;
          
          if (value1 === true)
                    {
            $scope.message = One;
          }
                    else
                    if (value2 === true)
                    {
            
                    $scope.message = Two;
          }
                    else if (value3 === true)
                    {
            
                    $scope.message = Three;
          }
                    else {
            
                    $scope.message = 'None';
          }
        }
      }, true);
                               
    $scope.sendToSwift = function(){
                    
    var choice = $scope.message;
                               
    var messgeToPost = {
    'Choice': choice};
    window.webkit.messageHandlers.theHandler.postMessage(messgeToPost)
    };
    }]);
})(angular);