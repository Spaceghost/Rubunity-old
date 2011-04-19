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
  
  $("#rails-version-list ul li").live('click', function() {
    $(this).toggleClass("active");
  })

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
  
  $('input#remove_topic').css('display', 'none');
  $('input#remove_rails_version').css('display', 'none');
  $('input#remove_ruby_version').css('display', 'none');
  
  $('#remove-topic-form span').live('click', function(){
    var text = $(this).text();
    $('input#remove_topic').val(text);
    $(this).remove();
    $('#remove_topic_form').submit();
    $("#topics span:contains(" + text + ")").remove();
  });
  
  $('#remove-rails-version-form span').live('click', function(){
    var text = $(this).text();
    $('input#remove_rails_version').val(text);
    $(this).remove();
    $('#remove_rails_version_form').submit();
    $("#rails-versions span:contains(" + text + ")").remove();
  });
  
  $('#remove-ruby-version-form span').live('click', function(){
    var text = $(this).text();
    $('input#remove_ruby_version').val(text);
    $(this).remove();
    $('#remove_ruby_version_form').submit();
    $("#ruby-versions span:contains(" + text + ")").remove();
  });
  
});
