$(document).on "turbolinks:load", ->
  if document.getElementById("contact-map")
    new ContactMap(document.getElementById("contact-map")).show();

class @ContactMap
  constructor: (@map, @address) ->
    @geocoder = new window.google.maps.Geocoder()
    console.info "Contact Map initialized..."

  show: () ->
    @findGeocodedAddress()

  findGeocodedAddress: () ->
    @geocoder.geocode "address": @_address(), (results, status) =>
      if status is "OK"
        @buildMap().setCenter results[0].geometry.location

  buildMap: () ->
    new google.maps.Map @map,
      center: {lat: -34.397, lng: 150.644},
      scrollwheel: false,
      zoom: 11

  _address: () ->
    @address ? @map.dataset.address
