$(document).ready( function() { 
  $('.tag').click( function() {

    var value = $(this).find('input').val();
    $('.tag').filter( function(index) {
      return $(this).find('input').val() == value;
    }).toggleClass('unsubscribed subscribed');
  });
});