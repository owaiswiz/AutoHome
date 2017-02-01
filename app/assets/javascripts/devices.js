$(document).ready(function(){
	var nameInput = $(".add-device input#device_name");
	var pinInput = $(".add-device input#device_pin");
	var roomInput = $(".add-device input#device_room");
	var typeInput = $(".add-device input#device_device_type");
	var iconInput = $(".add-device input#device_icon");
	var colorInput = $(".add-device input#device_color");
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

		if(dropdownInputInvalid(pinInput))
			valid=false;

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
				if ( redPin == greenPin || greenPin == bluePin || redPin == bluePin || redPin == "" || greenPin == "" || bluePin == "")
				{
					valid=false;
					$(".multi-pin-error").removeClass("hidden");
					pinsSelector.addClass("error");
				}
				else
				{
				}
			}


		if(typeInput.val() == "generic")
			if(dropdownInputInvalid(iconInput))
				valid=false


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
		if($(this).attr('id') == 'light')
		{
			$(".light-only").removeClass("hidden");
			$(".icon-selector").addClass("hidden");
		}
		else if($(this).attr('id') == 'generic')
		{
			$(".light-only").addClass("hidden");
			$(".icon-selector").removeClass("hidden");
		}
		else
		{
			$(".icon-selector").addClass("hidden");
			$(".light-only").addClass("hidden");
		}
	});

	$("input#device_multicolor").click(function(){
		$(".pin-selector").toggleClass("hidden");
		$(".pins-selector").toggleClass("hidden");
	});

	$(".multi-pin-selector").click(function(){
		$(this).parents("pins-selector").removeClass("error");
		$(".multi-pin-error").addClass("hidden");
	});

	$(".multi-pin-selector li a").click(function(){
		$(this).parents(".pins-selector").attr('data-' + $(this).parents(".dropdown.multi-pin-selector").attr('id'),$(this).attr('id'));
	});
});










