//ISOTOPE LIBRARY FOR RELAYOUT

$(document).ready(function(){
  
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
  	$.ajax({
  		method: "POST",
  		url: "/device/" + deviceId + "/state/" + change
  	});

	}

	function getTemperature($currentDevice)
	{
		var deviceId = $currentDevice.parents(".device").attr('id')
		$.ajax({
				method: "GET",
				url: "/device/" + deviceId + "/get_temperature",
				dataType: "json",
    				success: function(data){
        			$currentDevice.parents(".device").find(".temperature-value").text(data.temperature + " °C")
        			if(data.state == "enabled")
        				$currentDevice.removeClass('temperature-disabled').addClass("temperature-enabled")
        			else
        				$currentDevice.addClass('temperature-disabled').removeClass("temperature-enabled")
    			}        
			});
	}

	$(".device .temperature").each(function(){
		var $currentDevice=$(this)
		getTemperature($currentDevice)
		setInterval(function(){
			getTemperature($currentDevice)
		}, 10000);
	});

	$(".btn-set-limit-device").click(function(){
		var deviceId = $(this).parents(".device").attr('id')
		var limit = prompt("Please Enter the new Limit")
		$.ajax({
			method: "POST",
			url: "/device/" + deviceId + "/update_limit/" + limit
		});
	});
	$(".delete-device").click(function(){
		var deviceId = $(this).parents(".device").attr('id');
		$.ajax({
			method: "POST",
			url: "/device/" + deviceId + "/destroy"
		});
		$(this).parents(".device").detach();
		var data = $(this).parents(".devices").html()
		$(".devices").hide().html(data).fadeIn('fast');
	})
	//BrightnessHandler
	$('.brightnessInput').on('input change', function () {
		changeOpacity($(this).siblings("i.light"));
		$(this).siblings('.brightnessText').text("Brightness: " + $(this).val() + "%");
	});

	$('.brightnessInput').on('change',function(){
		var deviceId = $(this).parents(".device").attr('id');
		var brightness = $(this).val();
		$.ajax({
			method: "POST",
			url: "/device/" + deviceId + "/brightness/" + brightness
		});
	});

	//FanSpeedHandler
	$(".speedInput").on('input change',function(){
		var duration = 4.0*Math.pow(0.5,$(this).val()-1) + 's';
		$(this).siblings("i.fan").css("animation-duration",duration);
		$(this).siblings(".speedText").text("Speed: " + $(this).val());
	});

	$(".speedInput").on('change',function(){
		var deviceId = $(this).parents(".device").attr('id');
		var speed = $(this).val();
		$.ajax({
			method: "POST",
			url: "/device/" + deviceId + "/speed/" + speed
		});
	});
	$(".device i.light").click(function(){
		changeOpacity(this);
		$(this).toggleClass("light-enabled light-disabled");
		$(this).parents(".device-controls").find(".color-selector").toggleClass("multicolor-enabled multicolor-disabled")
		$(this).siblings(".brightnessInput").prop('disabled', function(i, v) { return !v; });
		changeState(this,"light-enabled")
	});

	$(".device .color-label").click(function(){
		var color = $(this).siblings('input').val();
		var deviceId = $(this).parents(".device").attr('id');
		$.ajax({
  		method: "POST",
  		url: "/device/" + deviceId + "/color/" + color
  	});
		$(this).parents(".device-controls").find("i.fa.fa-lightbulb-o").removeClass("red-light green-light yellow-light blue-light magenta-light cyan-light").addClass(color + "-light");
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


	$(".schedule-type-select").on('change',function(){
		if($(this).find(":selected").val() == "day")
		{
			$(this).parents(".schedule-type").find(".schedule-day-select").removeClass("hidden");
		}
		else
		{
			$(this).parents(".schedule-type").find(".schedule-day-select").addClass("hidden");
		}
	});


	$(".btn-schedule-submit").click(function(){
		var valid = true;
		var scheduleModal = $(this).parents(".schedule-modal");
		var deviceId = scheduleModal.attr('data-device-id');
		var scheduelType = scheduleModal.find(".schedule-type-select");
		var scheduleTypeVal = scheduelType.find(":selected").val();
		
		var scheduleDay = scheduleModal.find(".schedule-day-select");
		var scheduleDayVal="";
		
		if(scheduleTypeVal == "day")
		{
			scheduleDayVal = scheduleDay.find(":selected").val();
			if(scheduleDayVal=="")
			{
				valid=false;
			}
		}

		var scheduleHour = scheduleModal.find(".schedule-hour-select");
		var scheduleHourVal = scheduleHour.find(":selected").val();

		var scheduleMinute = scheduleModal.find(".schedule-minute-select");
		var scheduleMinuteVal = scheduleMinute.find(":selected").val();

		var scheduleState = scheduleModal.find(".schedule-state-select");
		var scheduleStateVal = scheduleState.find(":selected").val();

		if(scheduleTypeVal == "" || scheduleHourVal == "" || scheduleMinuteVal == "" || scheduleStateVal == "")
			valid = false;

		if(!valid)
		{
			scheduleModal.find(".schedule-error").removeClass("hidden");
			return false;
		}

		scheduleModal.find(".schedule-error").addClass("hidden");
		$.ajax({
			method: "POST",
			url: "/device/" + deviceId + "/schedule",
			data: {schedule_type:scheduleTypeVal,schedule_day:scheduleDayVal,schedule_hour:scheduleHourVal,schedule_minute:scheduleMinuteVal,schedule_state:scheduleStateVal} 
		});
		$(this).parents(".schedule-modal").modal('hide');
		$(".schedule-modal select").val("");
		return true;

	});
});


























