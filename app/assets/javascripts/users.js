$(document).ready(function() {
	initButtonListener();
});

function initButtonListener()
{
	$("input").change(function(){
		var row = $(this).closest('.row');
		// alert(row.attr('id'));
		var submit = row.find('button[type=submit]');
		submit.removeClass("disabled");
		submit.prop('disabled', false);
	});	
}

function resetButtonsState()
{
	$('.tooltipped').tooltip('remove');
	$('button[type=submit]').toggleClass('disabled');
	$('button[type=submit]').prop('disabled', true);
	$('.tooltipped').tooltip({delay: 50});
}