# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
twenty_four.Trip = 
  get_current_location: ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition twenty_four.Trip.got_location, twenty_four.Trip.didnt_get_location,
        enableHighAccuracy: true
        timeout: 20000
        maximumAge: 120000
    else
      alert "Sorry, your browser didn't tell us where you are"

  got_location: (position) ->
    $("#trip_latitude").val position.coords.latitude
    $("#trip_longitude").val position.coords.longitude
    $(".new_trip").submit()

  didnt_get_location: (error) ->
    alert "We didn't get your location because #{error.message}"

$ ->
  if $(".new_trip")
    twenty_four.Trip.get_current_location()
