/*
*= require jquery.min
*= require modernizr.min
*= require bootstrap.min
*/


$(document).ready(function () {
    $("a[data-toggle='tab']").on("shown.bs.tab", function (e) {
        
        $target = $(e.target)
        
        // Only one selected tab
        $("li.active").removeClass("active")
        $(e.target.parentNode).addClass("active")
        
        // Only one open tab
        $("ul ul").css("display", "none")

        if($target.hasClass("group") ){
          $target.siblings("ul").css("display", "table")
          
        } else {
          var group_li = e.target.parentNode.parentNode.parentNode;
          $(group_li).children("ul").css("display", "table")
        }
        
        var hash = $(e.target).attr("href");
        if (hash.substr(0,1) == "#") {
            location.replace("#" + hash.substr(5));
        }
    });

    // Let clicking on  DSL / language tabs persist
   
    if (location.hash.substr(0,1) == "#") {
        $("li.active").removeClass("active")
        $("a[href='#tab_" + location.hash.substr(1) + "']").tab("show");
    }

});
