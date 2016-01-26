$(document).ready(function()
{
	var debugTime = 5000;
	var productionTime = 60000;
    initCheckBoxAjax();

    // On refresh la page toutes les 2 minutes
    window.setInterval(refresh, productionTime * 2);
});

function initCheckBoxAjax()
{
	$('input[type=checkbox]').change(function(){
		$(this).closest('form.edit_order').trigger('submit.rails');
	});
}

function refresh()
{
	$('#refresh_form').trigger('submit.rails');
}