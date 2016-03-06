$(document).ready(function()
{
    initCategories();
});

function initCategories(){

    // Attribut un placeholder à l'image si celle-ci est introuvable
	$(".backup_picture").error(function(){
        $(this).attr('src', '/assets/categories/placeholder.png');
    });

    // Initialisation des tooltip
    $('.tooltipped').tooltip({delay: 50});

    // On cache le gif de chargement.
    $('.wait').hide();

    // On le montre lors d'un clic sur le bouton "voir"
    $('.async-action').click(function(){
    	$('.wait').show();
    });

    // Affichage de l'image dynamiquement lorsqu'on la sélectionne dans l'input file
    $('.fileWrapper').children('input[type=file]').change(function(){
        var card = $(this).closest('.card-image');
        var input = $(this)[0];
        if (input.files && input.files[0])
        {
            var filedr = new FileReader();
            filedr.onload = function(e) {
                var image = card.find('img.backup_picture');
                var test = image.attr('src');
                image.attr('src', e.target.result);
            };
            filedr.readAsDataURL(input.files[0]);
        }
    });

    // On cache tous les éléments du formulaires (qui ne doit s'afficher que lorsqu'on clique sur 'modifier')
    $('.form').hide();

    // Affichage du form et disparition des champs normaux lorsqu'on clique sur 'modifier'
    $('.btn-admin').click(function(){
		var card = $(this).closest('.card')
    	card.find('.form').show();
    	card.find('.normal').hide();  	
    });
}

function initMeals()
{
    // On cache le gif de chargement.
    $('.wait').hide();
    
    // Initialisation des tooltip materialize
    $('.tooltipped').tooltip({delay: 50});

    // Initialisation des dropdowns materialize
    $('select').material_select();

    // Initialisation des collapsibles materialize
    $('.collapsible').collapsible({
        accordion : false
    });

    // Initialisation des onglets materialize
    $('ul.tabs').tabs();
}