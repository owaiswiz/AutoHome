$(document).ready(function(){

	var doing=false;
	$('#rangeText').text($('#rangeInput').val());
  	// setup an event handler to set the text when the range value is dragged (see event for input) or changed (see event for change)
  $('#rangeInput').on('input change', function () {
  	$('#rangeText').text($(this).val());
  	if(!doing)
  	{
  		doing=true;
  		$.ajax( "/" ).done(delayRequest());
  	}
  	else
  		return false;
	});

	function delayRequest(){
		window.setTimeout(function(){
			doing=false;
		},2000);
	}
});