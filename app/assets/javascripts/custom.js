/*

Template Name: Myway
Template Demo: http://awerest.com/demo/myway

Purchase: http://themeforest.net/item/myway-onepage-bootstrap-parallax-retina-template/4058880?ref=awerest

Author: Awerest

Description: Onepage Bootstrap Multi-Purpose Parallax Retina Template
Tags: Responsive, Mobile First, Retina, Bootstrap 3, One Page, Multi Page, Multi-Purpose, Agency, Clean, Creative, Minimal, Components, Photography, Portfolio, Business, Corporate, White, Modern

Version: 2.5

---------------

Table of Contents:

1) Fix for Internet Explorer 10 in Windows 8 and Windows Phone 8
2) Animated elements
3) Carousels
	- Intro slider
	- Works slider
4) Intro section height
5) Contact form
6) SVG icons
7) Google map
	- Marker image and position
	- Map position
8) Collapse menu on tap/select
9) Smooth scroll on anchors
10) Gallery lightbox
11) Preloader
12) Href # fix for demo

---------------

*/

$(document).ready(function() {
	'use strict';

/* ==== 1) Fix for Internet Explorer 10 in Windows 8 and Windows Phone 8 ==== */

	if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
		var msViewportStyle = document.createElement("style")
		msViewportStyle.appendChild(
			document.createTextNode(
				"@-ms-viewport{width:auto!important}"
			)
		)
		document.getElementsByTagName("head")[0].appendChild(msViewportStyle)
	}

/* ==== 2) Animated elements ==== */

/* After all images are loaded, and if it's no-touch device, run script */

	imagesLoaded(document.body, function(){
		if ($('.no-touch').length) {
			skrollr.init({
				smoothScrolling: false,
				easing: 'sqrt',
				forceHeight: false
			});
		}
	});

/* ==== 3) Carousels ==== */


	
	$("#owl-carousel").owlCarousel({

	navigation: true, // Show next and prev buttons
	autoPlay: 5000,
	paginationSpeed: 400,
	singleItem: true,

	// "singleItem:true" is a shortcut for:

	// itemsDesktop : false,
	// itemsDesktopSmall : false,
	// itemsTablet: false,
	// itemsMobile : false
	
	});


/* ==== 4) Make intro section height of viewport / Minimum height is set to 445px in style.css ==== */

	$(function(){
		$('#intro').css({'height':($(window).height())+'px'});
		$(window).resize(function(){
		$('#intro').css({'height':($(window).height())+'px'});
		});
	});

/* ==== 5) Contact form ==== */


/* ==== 6) SVG icons ==== */

	var url ='/assets/streamline-icons.svg';
	var c=new XMLHttpRequest(); c.open('GET', url, false); c.setRequestHeader('Content-Type', 'text/xml'); c.send();
	document.body.insertBefore(c.responseXML.firstChild, document.body.firstChild)

	var url ='/assets/simpleline-icons.svg';
	var c=new XMLHttpRequest(); c.open('GET', url, false); c.setRequestHeader('Content-Type', 'text/xml'); c.send();
	document.body.insertBefore(c.responseXML.firstChild, document.body.firstChild)

	var url ='/assets/social-icons.svg';
	var c=new XMLHttpRequest(); c.open('GET', url, false); c.setRequestHeader('Content-Type', 'text/xml'); c.send();
	document.body.insertBefore(c.responseXML.firstChild, document.body.firstChild)

/* Add your set / See documentation */

/*
	var url ='css/your-file-name.svg';
	var c=new XMLHttpRequest(); c.open('GET', url, false); c.setRequestHeader('Content-Type', 'text/xml'); c.send();
	document.body.insertBefore(c.responseXML.firstChild, document.body.firstChild)
*/

/* ==== 7) Google map ==== */

});

$(window).load(function() {
	'use strict';

/* ==== 8) Collapse menu on tap/select on mobile and tablet devices ==== */

	if ($('.navbar-toggle:visible').length) {
		$('.navbar a').click(function () { $(".navbar-collapse").collapse("hide") });
	}

/* ==== 9) Smooth scroll on anchors ==== */

/* Add your anchor parent element class or ID */



/* ==== 10) Gallery lightbox ==== */

	$(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
		event.preventDefault();
		$(this).ekkoLightbox();
	});

/* ==== 11) Preloader ==== */

	$('.spinner').fadeOut('slow');
	$('.preloader').delay(350).fadeOut('slow');

/* ==== 12) Href # fix for demo ==== */

	$('a[href="#"]').click(function() {
		return false;
	});

});