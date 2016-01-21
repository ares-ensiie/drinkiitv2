$(document).ready(function()
{
    initIngredients();
});

function initIngredients(){
	$('.tooltipped').tooltip('remove');
	$('.tooltipped').tooltip({delay: 50});
	$('.submit').prop('disabled', true);
	$('.submit').addClass("disabled");
	$("input").change(function(){
		var row = $(this).closest('.row');
		var submit = row.find('button[type=submit]');
		submit.removeClass("disabled");
		submit.prop('disabled', false);
	});	
}