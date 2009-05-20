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
	var mapstraction = new Mapstraction('map','yahoo');

	      var myPoint = new LatLonPoint(38.589638,-9.051619);
	      // display the map centered on a latitude and longitude (Google zoom levels)
	      mapstraction.setCenterAndZoom(myPoint, 11);
	      mapstraction.addOverlay("http://student.dei.uc.pt/~braposo/teste.kml")
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
	//jQuery('#navbar').jparallax({ },{xtravel: '50px',ytravel: '0px'}, {xtravel: '80px',ytravel: '0px'}, {xtravel: '100px',ytravel: '0px'});
	
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
	
	if ($('input#trace_tag_list').length) { 
		$('input#trace_tag_list').tagSuggest({
    		url: '/tag_list/',
			tagContainer: 'div',
			delay: '500'
  		});
	}
 
	
	if ($('#map').length) { 
		//google.setOnLoadCallback(gmaps_init); 
		mapstraction_init();
	}
	
	/* COLLAPSE */
	$('.box .box-header .box-options .collapse').click(function (e) {
		button = $(this);
		box = $(this).parent().parent().parent();
		$(".box-content", box).slideToggle("slow", function (e) { 
			if ($(this).is(':visible'))
				button.attr({ src: '/images/icons/collapse.png'});
			else 
				button.attr({ src: '/images/icons/expand.png' });
		 });
		
	});
	
	/* SWITCH VIEW OPTIONS */
	$(".box .box-header .box-options img.layout").toggle(
		function(){
			box = $(this).parent().parent().parent();
			$("div.profile-list", box).fadeOut("fast", function() {
				$(this).fadeIn("fast").addClass("item-list");
				$(this).fadeIn("fast").removeClass("profile-list");
			});
		}, function () {
			$("div.item-list", box).fadeOut("fast", function() {
				$(this).fadeIn("fast").removeClass("item-list");
				$(this).fadeIn("fast").addClass("profile-list");
			});
		}
	); 
	
	/* SEARCH BOX */
	$("a.search").click(function(e){ e.preventDefault(); $(".search-tooltip").is(':hidden')?  $(".search-tooltip").show() : $(".search-tooltip").hide(); });
	$('a.search, .search-tooltip').click(function(e) { e.stopPropagation(); });
	$(document).click(function() { $('.search-tooltip').hide();});
	
	/* GRID */
	$('.yui-u').sortable({ 
		items: '.box', 
		opacity: '0.5',  
		connectWith: $('.yui-u'), 
		handle: '.box-header .box-options img.move', 
		placeholder: 'drop-hover', 
		cursor: 'move', 
		cursorAt: { top: 20, left: 260 },
		scroll: false,
		tolerance: 'pointer', 
		helper: 'clone',
		revert: true, 
		start: function(e,ui) { $('.box-content', ui.helper).hide(); ui.helper.css({width: '300px'});  },
	});
	
	/* ACTIVITY STREAM PAGINATION */
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

	/* TOOLTIPS */
	$('.box-options img[tooltip]').each(function() {
		$(this).qtip({
			content: $(this).attr('tooltip'),
			style: { 
				name: 'dark',
				tip: { 
					corner: 'bottomRight',
					size: {
						x: 10,
						y: 5
					}
				},
				border: { width: 1 }
			},
			position: {
				corner: {
					target: 'topMiddle',
					tooltip: 'bottomRight'
				}
			}
		});
	});
	
});