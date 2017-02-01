$(document).ready(function(){
  
	var doing = false;
	function delayRequest(){
		window.setTimeout(function(){
			doing=false;
		},400);
	}

	function changeOpacity(ele){
		$(ele).css("opacity",$(ele).siblings(".brightnessInput").val()/100.0 + 0.3)
	}

	function changeState(ele,state)
	{
		var deviceId = $(ele).parents(".device").attr('id');
		var change = "";
		if($(ele).hasClass(state))
			change="enable"
		else
			change="disable"
  	$.ajax("/device/" + deviceId + "/state/" + change);

	}

	//BrightnessHandler
  $('.brightnessInput').on('input change', function () {
  	changeOpacity($(this).siblings("i.light"));
  	$(this).siblings('.brightnessText').text("Brightness: " + $(this).val() + "%");
  	if(!doing)
  	{
  		doing=true;
  		$.ajax({url:"/",data:{name: "Owais"}}).done(delayRequest());
  	}
  	else
  		return false;
	});

  //FanSpeedHandler
  $(".speedInput").on('input change',function(){
  	var duration = 4.0*0.5**($(this).val()-1) + 's';
  	$(this).siblings("i.fan").css("animation-duration",duration);
  	$(this).siblings(".speedText").text("Speed: " + $(this).val());
  	if(!doing)
  	{
  		doing=true;
  		$.ajax( "/" ).done(delayRequest(doing));
  	}
  });


	$(".device i.light").click(function(){
		changeOpacity(this);
		$(this).toggleClass("light-enabled light-disabled");
		$(this).siblings(".brightnessInput").prop('disabled', function(i, v) { return !v; });
		changeState(this,"light-enabled")
	});

	$(".device .color-label").click(function(){
		$(this).parents(".device-controls").find("i.fa.fa-lightbulb-o").css("color",$(this).siblings("input").val());
		$(this).parents(".color-selector").find(".color-label").removeClass("active-color");
		$(this).addClass("active-color")
	});

	$(".device i.fan").click(function(){
		$(this).siblings(".speedInput").prop('disabled', function(i, v) { return !v; });
		$(this).toggleClass("fan-enabled fan-disabled fa-spin")
		changeState(this,"fan-enabled")
	});

	$(".device i.generic").click(function(){
		$(this).toggleClass("generic-enabled generic-disabled");
		changeState(this,"generic-enabled")
	});

});





















