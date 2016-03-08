var clickCount = 0;
var k = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65], n = 0;

$(window).load(function(){
	// $("#my_account").hide()
	$('.slider').slider({full_width: true});
	clickCount = 0;
	$('#clickCount').click(function(){
		clickCount++;
		if (clickCount == 10)
		{
			Materialize.toast("Je sais que t'es pauvre mais c'est pas mon problème", 4000, 'red');
			clickCount = 0;
		}
	});
});

$(document).keydown(function (e) {
    if (e.keyCode === k[n++]) {
        if (n === k.length) {
            Materialize.toast("Argent en masse !", 4000, 'green');
			document.getElementById('topup').click();
			clickCount = 0;
            n = 0;
            return false;
        }
    }
    else {
        n = 0;
    }
});

// $(document).ready(function () {
// 	$('#my_account').hide();
// 	if($($( "#noti" ).children()[0]).text() != "") {
//   	$( "#noti" ).fadeIn( "slow" );
//   	setTimeout(function (){
//     	$( "#noti" ).fadeOut( "slow" );
//   	}, 1000);
// 	}

// 	$('#account_button').click(function (e) {
// 		e.preventDefault();
// 		$('#my_account').fadeIn();
// 	});

// 	$(document).click(function (e) {
// 		if ($(e.target).closest('#my_account').length > 0 || $(e.target).closest('#account_button').length > 0) return;
// 	    $('#my_account').fadeOut();
// 	});
// });