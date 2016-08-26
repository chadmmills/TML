$(document).on "contact-map:load", ->
  new ContactMap(document.getElementById("contact-map")).show();

class @ContactMap
  constructor: (@map) ->
    @geocoder = new google.maps.Geocoder()
    console.info "Contact Map initialized..."

  show: () ->
    @findGeocodedAddress()
    @showMap()
    @placeMarkerOnMap()

  findGeocodedAddress: (@googleMap) ->
    @geocoder.geocode "address": @map.dataset.address, (results, status) =>
      if status is "OK"
        @buildMap().setCenter results[0].geometry.location


  buildMap: () ->
    new google.maps.Map @map,
      center: {lat: -34.397, lng: 150.644},
      scrollwheel: false,
      zoom: 12

