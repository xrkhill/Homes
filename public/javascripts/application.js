// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
  // hilight the last item edited
  if (location.hash) {
    if (location.hash.split('_')[0] == '#row') {
      $('tr' + location.hash).addClass('selected');
    }
  }

  //*
  // hilight the item clicked
  $('table td.price').toggle(function(){
    $(this).parent().addClass('marked');
  },function(){
    $(this).parent().removeClass('marked');
  });
  //*/
});
