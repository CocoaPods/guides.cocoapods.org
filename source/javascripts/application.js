/*
*= require jquery.min
*= require modernizr.min
*= require bootstrap.min
*/


$(document).ready(function () {
    $('#pull-request').popover()
  
  
    $("a[data-toggle='tab']").on("shown.bs.tab", function (e) {
        
        $target = $(e.target)
        
        // Only one selected tab
        $(".bs-sidebar li.active").removeClass("active")
        $(e.target.parentNode).addClass("active")
        
        // Only one open tab collection
        $("ul ul").css("display", "none")
        
        if($target.hasClass("group") ){
          // Top level node clicked
          $target.siblings("ul").css("display", "block")
          
        } else {
          var group_li = e.target.parentNode.parentNode.parentNode;
          $(group_li).children("ul").css("display", "block")
        }
        
        var hash = $(e.target).attr("href");
        if (hash.substr(0,1) == "#") {
            location.replace("#" + hash.substr(5));
        }
    });

    // Let clicking on  DSL / language tabs persist
   
    if (location.hash.substr(0,1) == "#") {
        $(".bs-sidebar li.active").removeClass("active")
        $("a[href='#tab_" + location.hash.substr(1) + "']").tab("show");
    }

});
