$(document).ready(function()
{
    initIngredients();
});

function initIngredients(){

	// Initialisation des tooltips materialize
	$('.tooltipped').tooltip({delay: 50});

	// On disable les boutons de validation des modifs tant qu'on a rien touché
	$('.submit').prop('disabled', true);
	$('.submit').addClass("disabled");

	// On active les boutons dès qu'on change quelque chose dans le formulaire
	$("input").change(function(){
		var row = $(this).closest('.row');
		var submit = row.find('button[type=submit]');
		submit.removeClass("disabled");
		submit.prop('disabled', false);
	});	
}