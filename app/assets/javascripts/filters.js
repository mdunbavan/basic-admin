$(document).ready(function(){
  // Allows will paginate to work via AJAX is inside a div with id js-pagination
  $("body").on("click", ".js-pagination a", function(e){
    e.preventDefault();
    $.getScript(this.href);
    $("html, body").animate({ scrollTop: 0 }, "fast");
  });

  // Handles submitting the filter form via ajax with a timeout of 300
  // to stop multiple submissions when the user is typing quickly
  var filterTimeOut;
  $("body").on("change keyup paste", "#filter-bar :input[type=text], #filter-bar :input[type=date]", function(e){
    clearTimeout(filterTimeOut);
    filterTimeOut = setTimeout(function(){ $("#filter-bar form").submit(); }, 300);
  });

  $("body").on("change keyup paste", "#filter-bar select", function(e){
    clearTimeout(filterTimeOut);
    $("#filter-bar form").submit();
  });
});