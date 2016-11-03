window.Views ?= {}
class window.Views.MapMarker extends google.maps.OverlayView

  constructor: (@view, @image) ->
    @bounds = new google.maps.LatLngBounds(
      new google.maps.LatLng @image.lat, @image.lng,
      new google.maps.LatLng @image.lat, @image.lng
    )
    @image.post.on 'inviewport.change', () =>
      @draw()
    @setMap @view.googleMap

  build = (image) ->
    marker = elem 'div.mapMarker',
      'data-post': image.post.id
    markerImg = elem 'div.mapMarker__image',
      style: "background-image: url(#{image.url_thumb})"
    marker.appendChild markerImg
    marker

  elem = (elemStr, attributes = {}) ->
    elemArr = elemStr.split '.'
    el = document.createElement elemArr.shift()
    while elemArr.length > 0
      el.classList.add elemArr.shift()
    for k, v of attributes
      el.setAttribute k, v
    el

  onAdd: ->
    @marker = build @image
    panes = @getPanes()
    panes.overlayMouseTarget.appendChild @marker
    google.maps.event.addDomListener @marker, 'click', (ev) ->
      ev.preventDefault()
      id = @.dataset.post
      postEl = document.getElementById id
      rect = postEl.getBoundingClientRect()
      document.body.scrollTop = rect.top

  draw: =>
    overlayProjection = @getProjection()
    sw = overlayProjection.fromLatLngToDivPixel @bounds.getSouthWest()
    se = overlayProjection.fromLatLngToDivPixel @bounds.getNorthEast()
    @marker.style.left = "#{sw.x}px"
    @marker.style.top = "#{se.y}px"
    if @image.post.isInViewport() && !@marker.classList.contains 'is--active'
      @marker.classList.add 'is--active'
      @view.flyToMarker @
    else if !@image.post.isInViewport()
      @marker.classList.remove 'is--active'
