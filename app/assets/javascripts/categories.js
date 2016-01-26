$(document).ready(function()
{
    init();
});

function init(){
	$(".backup_picture").error(function(){
        $(this).attr('src', '/assets/categories/placeholder.png');
    });
    $('.tooltipped').tooltip({delay: 50});
    $('.wait').hide();
    $('.async-action').click(function(){
    	$('.wait').show();
    });
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
    $('.form').hide();
    $('.btn-admin').click(function(){
		var card = $(this).closest('.card')
    	card.find('.form').show();
    	card.find('.normal').hide();  	
    });
    $('select').material_select();
    $('.collapsible').collapsible({
        accordion : false
    });
    $('ul.tabs').tabs();
}