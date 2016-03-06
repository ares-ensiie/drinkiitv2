$(document).ready(function()
{
	// Temps à attendre entre deux refreshs
	var debugTime = 5000;
	var productionTime = 60000;

	// Initialisation de l'envoi d'une requête AJAX lorsqu'on change la valeur d'une checkbox
    initCheckBoxAjax();

    // On refresh la page toutes les 2 minutes
    window.setInterval(refresh, productionTime * 2);
});

function initCheckBoxAjax()
{
	// On récupère le formulaire contenant la checkbox cliquée, et on le submit en asynchrone (data-remote = true)
	$('input[type=checkbox]').change(function(){
		$(this).closest('form.edit_order').trigger('submit.rails');
	});
}

// Refresh simplement la page en submitant le formulaire invisible en fin de page
function refresh()
{
	$('#refresh_form').trigger('submit.rails');
}

function refreshCollapsibles()
{
	$('.collapsible').collapsible({
		accordion : false
	});
}

function refreshMyOrders()
{
	$('.tooltipped').tooltip('remove');
	$('#content').html("<%= j (render 'myorders') %>");
	$('.collapsible').collapsible({
		accordion : false
	});
	$('.tooltipped').tooltip({delay: 50});
}

function refreshOrders()
{
	$('.tooltipped').tooltip('remove');
	$('#content').html("<%= j (render 'orders') %>");
	$('.collapsible').collapsible({
		accordion : false
	});
	$('.tooltipped').tooltip({delay: 50});
	initCheckBoxAjax();
}