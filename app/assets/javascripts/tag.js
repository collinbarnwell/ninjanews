$(document).ready( function() { 
  $('.tag').click( function() {
    debugger;
    var text = $(this).text();
    $('.tag').filter( function(index) {
      return $(this).text() === text;
    }).toggleClass('unsubscribed subscribed');
  });
});