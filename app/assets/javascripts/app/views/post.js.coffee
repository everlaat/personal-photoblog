window.Views ?= {}
class window.Views.Post extends App.View
  constructor: (@element) ->
    @images = null
    @id = @element.id
    @inViewport = false
    @addEventListeners()
    @isInViewport()

  addEventListeners: ->
    # window.addEventListener 'scroll', @isInViewport
    # window.addEventListener 'resize', @isInViewport
    for imagesEl in @element.querySelectorAll '.post__images__image'
      imagesEl.addEventListener 'click', @onImagesClick if imagesEl

  isInViewport: =>
    rect = @element.getBoundingClientRect()
    mh = mapHeight()
    t = rect.top - mh
    v = window.innerHeight
    b = t + @element.clientHeight
    inViewport = (t >= 0 || b >= 0) && (b <= v)
    if inViewport != @inViewport
      @inViewport = inViewport
      @emit 'inviewport.change', { inViewport: inViewport, id: @id }
    return @inViewport

  mapHeight = ->
    map = document.getElementById 'locations'
    if !map || map.clientHeight == window.innerHeight
      return 0
    else
      return map.clientHeight

  getImages: =>
    if @images == null
      @setImages()
    @images

  setImages: (images = false) =>
    if !images
      images = JSON.parse @element.dataset.images
      firstImageWithLocation = null
      for img in images
        if img.lat != null
          firstImageWithLocation = img
          break
      if firstImageWithLocation != null
        for img in images
          if img.lat == null
            img.lat = parseFloat firstImageWithLocation.lat
            img.lng = parseFloat firstImageWithLocation.lng
            img.lat += 0.0001 - (Math.random() * 0.0002)
            img.lng += 0.0001 - (Math.random() * 0.0002)
    @images = images

  onImagesClick: (ev) =>
    @emit 'post.openimageset',
      images: @images,
      index: +ev.currentTarget.dataset.index || 0
