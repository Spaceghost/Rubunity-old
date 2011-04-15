$(function() {
  	$('a[rel*=fancybox]').fancybox({
			'showNavArrows'      : false,
			'hideOnContentClick' : false
		});
  
  $('#logo').click(function() {
    window.location = "/";
  });
  
  //$('#ruby-version-form').hide();
  
  $("#rails-version-list").live('ajax:succes', function(){
    alert('Success');
    return true;
  });
  

  $('.up_vote').click(function() {
    //alert($(this).attr('value'));
    window.location.href = "/bookmark/vote/" + $(this).attr('value');
  });
  
  $('.add-topic-link').click(function() {
    $('input#topic').focus();
  });
  
  $('.add-ruby-link').click(function() {
    $('input#ruby_version').focus();
  });
  
  $('.version_check_box').click(function(){
    var check_me = $(this).find(":checkbox");
    
    if (check_me.is(':checked')) {
      check_me.attr('checked', false);
    } else {
      check_me.attr('checked', true);
    };
  });
  
});
