// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
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

	
	/*var blueIcon = new GIcon(G_DEFAULT_ICON);
        blueIcon.image = "/images/mark.png";

		// Set up our GMarkerOptions object
		markerOptions = { icon:blueIcon };

        // Add 10 markers to the map at random locations
        var bounds = map.getBounds();
        var southWest = bounds.getSouthWest();
        var northEast = bounds.getNorthEast();
        var lngSpan = northEast.lng() - southWest.lng();
        var latSpan = northEast.lat() - southWest.lat();
        for (var i = 0; i < 10; i++) {
          var latlng = new GLatLng(southWest.lat() + latSpan * Math.random(),
                                  southWest.lng() + lngSpan * Math.random());
          map.addOverlay(new GMarker(latlng, markerOptions));
        }*/
 
}

function mapstraction_init(){
	var mapstraction = new Mapstraction('map','microsoft');

	      var myPoint = new LatLonPoint(41.875696,-87.624207);
	      // display the map centered on a latitude and longitude (Google zoom levels)
	      mapstraction.setCenterAndZoom(myPoint, 11);
	      mapstraction.addOverlay("http://mapgadgets.googlepages.com/cta.kml")
		mapstraction.addControls({
		    pan: false, 
		    zoom: false,
		    map_type: false 
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
	jQuery('#navbar').jparallax({},{xtravel: '50px',ytravel: '0px'}, {xtravel: '80px',ytravel: '0px'}, {xtravel: '100px',ytravel: '0px'});
	
	$('a.modal').click(function (e) {
		e.preventDefault();
		// load the contact form using ajax
		$.get("/account/login", function(data){
			// create a modal dialog with the data
			$('.login-content',data).modal({
				close: false,
				position: ["15%",],
				overlayId: 'login-overlay',
				containerId: 'login-box',
				onShow: login.show,
			});
		});	
	});
	
	$('input#trace_tag_list').tagSuggest({
    	url: '/tag_list/',
		tagContainer: 'div',
		delay: '500'
  	});
 
	
	if ($('#map').length) { 
		google.setOnLoadCallback(gmaps_init); 
		//mapstraction_init();
	}
	
	/* COLLAPSE */
	$('.box .box-header').dblclick(function (e) {
	      $(".box-content", $(this).parent()).slideToggle("slow");
	});
	
	/* CHANGE VIEW OPTIONS */
	$(".box .box-header").toggle(function(){
			$("div.profile-list", $(this).parent()).fadeOut("fast", function() {
				$(this).fadeIn("fast").addClass("item-list");
				$(this).fadeIn("fast").removeClass("profile-list");
			});
		}, function () {
			$("div.item-list", $(this).parent()).fadeOut("fast", function() {
				$(this).fadeIn("fast").removeClass("item-list");
				$(this).fadeIn("fast").addClass("profile-list");
			});
	}); 
	
	/* SEARCH BOX */
	$("a.search").click(function(e){ e.preventDefault(); $(".search-tooltip").is(':hidden')?  $(".search-tooltip").show() : $(".search-tooltip").hide(); });
	$('a.search, .search-tooltip').click(function(e) { e.stopPropagation(); });
	$(document).click(function() { $('.search-tooltip').hide();});
	
	/* GRID */
	$('.yui-u').sortable({ 
		items: '.box', 
		opacity: '0.5',  
		connectWith: $('.yui-u'), 
		handle: '.box-header img', 
		placeholder: 'drop-hover', 
		cursor: 'move', 
		tolerance: 'pointer', 
		helper: 'clone',
		revert: true, 
		start: function(e,ui) { $('.box-content', ui.helper).hide(); ui.helper.css({width: '300px'});  },
	});
	
	/*$('div.pagination a').livequery('click', function() {
	    $('#events-list').load(this.href)
	    return false
	  })*/
	
	$('div.pagination a').live("click",function(e) {
		e.preventDefault();
		$.ajax({ 
			url: this.href, 
			data: { type: 'js'},
			dataType: 'html',
			success: function(html) { 
				$('#events-list').html(html).effect("highlight", { color: '#FCFFE7' }, 2000 );
		    }
		});
	});
	
	$(document).bind('keydown',{ combi:'j', disableInInput: true }, function() { $('a.next_page').trigger('click'); });
	$(document).bind('keydown',{ combi:'k', disableInInput: true }, function() { $('a.prev_page').trigger('click'); });

});