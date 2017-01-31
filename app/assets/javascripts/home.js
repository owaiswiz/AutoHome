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
	});

	$(".device .color-label").click(function(){
		$(this).parents(".device-controls").find("i.fa.fa-lightbulb-o").css("color",$(this).siblings("input").val());
		$(this).parents(".color-selector").find(".color-label").removeClass("active-color");
		$(this).addClass("active-color")
	});

	$(".device i.fan").click(function(){
		$(this).toggleClass("fan-enabled fan-disabled fa-spin")
	});

	$(".device i.generic").click(function(){
		$(this).toggleClass("generic-enabled generic-disabled");
	});
});
