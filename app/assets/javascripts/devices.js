$(document).ready(function(){
	var nameInput = $(".add-device input#device_name");
	var pinInput = $(".add-device input#device_pin");
	var roomInput = $(".add-device input#device_room");
	var typeInput = $(".add-device input#device_device_type");
	var iconInput = $(".add-device input#device_icon");
	var colorInput = $(".add-device input#device_color");
	var redInput = $(".add-device input#device_red_pin");
	var greenInput = $(".add-device input#device_green_pin");
	var blueInput = $(".add-device input#device_blue_pin");
	var extraInput = $(".add-device input#device_extra");
	var limitInput = $(".add-device input#limit")
	function addErrorToDropdown(element){
		element.siblings("button.dropdown-toggle").addClass("error");
	}

	function dropdownInputInvalid(element){
		if(element.val() == 0)
		{
			addErrorToDropdown(element);
			return true
		}
	}
	$("input").click(function(){
		$(this).removeClass("error");
	});

	$(".add-device-button").click(function(){
		var valid = true;
		if(!nameInput.val().replace(/ /g,'').length > 0)
		{
			nameInput.addClass("error");
			valid=false;
		}

		if(dropdownInputInvalid(roomInput))
			valid=false

		if(dropdownInputInvalid(typeInput))
		{
			valid=false
			return false;

		}

				
		if(typeInput.val() == "light")
			if(dropdownInputInvalid(colorInput))
				valid=false
			if($("input#device_multicolor").is(":checked"))
			{
				var pinsSelector = $(".pins-selector")
				var redPin = pinsSelector.attr('data-red-pin');
				var greenPin = pinsSelector.attr('data-green-pin');
				var bluePin = pinsSelector.attr('data-blue-pin');
				if ( redPin == greenPin || greenPin == bluePin || redPin == bluePin || redPin == "" || greenPin == "" || bluePin == "" || dropdownInputInvalid(redInput) || dropdownInputInvalid(greenInput) || dropdownInputInvalid(blueInput))
				{
					valid=false;
					$(".multi-pin-error").removeClass("hidden");
					pinsSelector.addClass("error");
				}
			}


		if(typeInput.val() == "generic")
			if(dropdownInputInvalid(iconInput))
				valid=false

		if(typeInput.val() == "temperature")
			if(!extraInput.val().replace(/ /g,'').length > 0)
			{
				extraInput.addClass("error");
				valid=false;
			}
			else
				extraInput.val(extraInput.val()+"andthelimit="+limitInput.val())
					
		if(!$("input#device_multicolor").is(":checked"))
			if(dropdownInputInvalid(pinInput))
				valid=false;


		if(valid)
			return true
		return false
	});
	$(".add-device .dropdown-menu li a").click(function(){
		var dropdownButton = $(this).parents(".dropdown").find("button.dropdown-toggle");
		var afterSelectText = dropdownButton.attr('data-label')
		dropdownButton.html(afterSelectText + $(this).html());
		dropdownButton.addClass("completed")
		dropdownButton.removeClass("error");
		$(this).parents(".dropdown").find("input" + "." + $(this).attr('class') + "-input").val($(this).attr('id'));
	})

	$(".add-device .dropdown.type-selector .dropdown-menu li a").click(function(){
		$(".extra-add-device").addClass("hidden");
		$(".icon-selector").addClass("hidden");
		$(".light-only").addClass("hidden");
		$(".limit-add-device").addClass("hidden")
		if($(this).attr('id') == 'light')
		{
			$(".light-only").removeClass("hidden");
		}
		else if($(this).attr('id') == 'generic')
		{
			$(".icon-selector").removeClass("hidden");
		}
		else if($(this).attr('id') == 'temperature')
		{
			$(".extra-add-device").removeClass("hidden");
			$(".limit-add-device").removeClass("hidden")
		}
	});

	$("input#device_multicolor").click(function(){
		$(".pin-selector").toggleClass("hidden");
		$(".pins-selector").toggleClass("hidden");
	});

	$(".multi-pin-selector").click(function(){
		$(this).parents(".pins-selector").removeClass("error");
		$(".multi-pin-error").addClass("hidden");
	});

	$(".multi-pin-selector li a").click(function(){
		var colorPin = $(this).parents(".dropdown.multi-pin-selector").attr('id');
		var inputClass = "new-device-" + colorPin + '-input'; 
		var inputElement = $("input." + inputClass);
		inputElement.val($(this).attr('id'));
		$(this).parents(".pins-selector").attr('data-' + $(this).parents(".dropdown.multi-pin-selector").attr('id'),$(this).attr('id'));
	});
});










