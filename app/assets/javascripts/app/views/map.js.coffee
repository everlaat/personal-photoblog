window.Views ?= {}
class window.Views.Map
  constructor: (element) ->
    @initMap()
    @markers = []

  addImages: (images) =>
    for image in images
      @addImage image

  addImage: (image) ->
    marker = new Views.MapMarker @, image
    @markers.push marker

  flyToMarker: (marker) ->
    return if @flying
    @flying = true
    @googleMap.panTo marker.bounds.getCenter()
    setTimeout( =>
      @flying = false
    , 100)

  flyToPost: (post) ->
    return if @flying
    @flying = true
    bounds = new google.maps.LatLngBounds()
    for image in post.getImages()
      pos = new google.maps.LatLng(image.lat, image.lng)
      bounds['extend'](pos)
    @googleMap.fitBounds bounds
    setTimeout( =>
      @flying = false
    , 100)

  initMap: =>
    @googleMap = new google.maps.Map document.getElementById('locations-map'),
      mapTypeId: 'terrain'
      disableDefaultUI: false
      center:
        lat: -34.397
        lng: 150.644
      zoom: 12
      styles: [{"featureType":"administrative","elementType":"all","stylers":[{"visibility":"on"},{"lightness":33}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#f2e5d4"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#c5dac6"}]},{"featureType":"poi.park","elementType":"labels","stylers":[{"visibility":"on"},{"lightness":20}]},{"featureType":"road","elementType":"all","stylers":[{"lightness":20}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#c5c6c6"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#e4d7c6"}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#fbfaf7"}]},{"featureType":"water","elementType":"all","stylers":[{"visibility":"on"},{"color":"#acbcc9"}]}]
