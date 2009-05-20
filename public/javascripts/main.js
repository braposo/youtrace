if ($('#map').length) { google.load("maps", "2.x"); }

var login = {
	message: null,
	show: function (dialog) {
		$('#login-overlay').click(function (e) {
			$.modal.close();
		});
	}
};

// Call this function when the page has been loaded
function gmaps_init() {
    var map = new google.maps.Map2(document.getElementById("map"));
	var uiOptions = map.getDefaultUI();
	uiOptions.controls.largemapcontrol3d  = false;
	uiOptions.controls.smallzoomcontrol3d = true;
	uiOptions.controls.maptypecontrol  = false;
	map.setUI(uiOptions);
	
    //map.setCenter(new google.maps.LatLng(40.203329,-8.405614), 13);
 	map.setCenter(new GLatLng(38.589638,-9.051619), 11); 

	//geoXml = new GGeoXml("http://student.dei.uc.pt/~braposo/passeio.kml");
	//map.addOverlay(geoXml);
    map.disableScrollWheelZoom();
	$('div#preview').click(function (e) {
		geoXml = new GGeoXml("http://student.dei.uc.pt/~braposo/teste.kml");
		map.addOverlay(geoXml);
	});
}


$(document).ready(function() {  
	//Efeito do footer
    $('a.nudge').hover(function() { //mouse in  
        $(this).animate({ paddingLeft: '10px' }, 300);  
    }, function() { //mouse out  
        $(this).animate({ paddingLeft: 0 }, 300);  
    });  

	//Efeito do menu navegação
	//jQuery('#navbar').jparallax({},{xtravel: '50px',ytravel: '0px'}, {xtravel: '80px',ytravel: '0px'}, {xtravel: '100px',ytravel: '0px'});
	
	/* MODAL DO LOGIN */
	$('a.modal').click(function (e) {
		e.preventDefault();
		// load the contact form using ajax
		$.get($(this).attr("href"), function(data){
			// create a modal dialog with the data
			$('.login-content',data).modal({
				close: false,
				position: ["5%",],
				overlayId: 'login-overlay',
				containerId: 'login-box',
				onShow: login.show,
			});
		});	
	});
	
	if ($('#map').length) { 
		google.setOnLoadCallback(gmaps_init); 
		//mapstraction_init();
	}
});