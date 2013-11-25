$(document).ready( function(){
	
	// Loading Bar Element Create
	var mask = $('<div />', {
		id: 'mask'
	});
	var loadingBar =  $('<div />', {id: 'loadingBar'});
	loadingBar.prepend($('<img />', {
		src: '/assets/img/ajax-loader.gif'
	}));
	$('body').prepend(mask).prepend(loadingBar);
	
	
	// Ajax Event Binding
	$('#mask')
	.bind('ajaxStart', function(e){
		
		e.preventDefault();
		
		var maskHeight = $(document).height();  
	    var maskWidth = $(window).width();
		
		$(this).css( {'width':maskWidth,'height':maskHeight, opacity: 0.8} );
		$(this).show();
    	// $(this).fadeIn(100);      
    	// $(this).fadeTo("fast",0.8);
    	
	})
	.bind('ajaxComplete', function(e){
		e.preventDefault();
		$(this).hide();
	});
	
	
	$('#loadingBar')
	.bind('ajaxStart', function(){
		var left = ( $(window).scrollLeft() + ($(window).width() - $(this).width()) / 2 );
	    var top = ( $(window).scrollTop() + ($(window).height() - $(this).height()) / 2 );
	    $(this).css({'left':left,'top':top, 'position':'absolute'});
	    
	    $('body').css('position','relative').append($(this));
	    $(this).show();
	})
	.bind('ajaxComplete', function(){
		$(this).hide();
	});
	
	
	$.ajaxSetup({
		cache: true,
		dataType: 'json',
		error: function(xhr, status, error){
			alert('An error occurred: ' + error);
		},
		timeout: 10000,
		type: 'GET'
	});
	
});


/*function maskWindow(event){
    
	event.preventDefault();
    var maskHeight = $(document).height();  
    var maskWidth = $(window).width();  
    
    if($('#mask')){
    	$('#mask').css({'width':maskWidth,'height':maskHeight});
    	$('#mask').fadeIn(100);      
    	$('#mask').fadeTo("fast",0.8);
    }
    //Loading Bar Display
    var $layerPopupObj = $('#loadingBar');
    if($layerPopupObj){
	    var left = ( $(window).scrollLeft() + ($(window).width() - $layerPopupObj.width()) / 2 );
	    var top = ( $(window).scrollTop() + ($(window).height() - $layerPopupObj.height()) / 2 );
	    $layerPopupObj.css({'left':left,'top':top, 'position':'absolute'});
	    $('body').css('position','relative').append($layerPopupObj);
	    
	    $('#loadingBar').show();
    }
 }*/

/*function unmaskWindow(event){
	event.preventDefault();
	if($('#mask')) $('#mask').hide();
	
	var $layerPopupObj = $('#loadingBar');
    if($layerPopupObj) $layerPopupObj.hide(); 
}*/