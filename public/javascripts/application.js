// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {  
    $('a.nudge').hover(function() { //mouse in  
        $(this).animate({ paddingLeft: '10px' }, 300);  
    }, function() { //mouse out  
        $(this).animate({ paddingLeft: 0 }, 300);  
    });  

	jQuery('#navbar').jparallax({},{xtravel: '50px',ytravel: '0px'}, {xtravel: '80px',ytravel: '0px'}, {xtravel: '100px',ytravel: '0px'});
});