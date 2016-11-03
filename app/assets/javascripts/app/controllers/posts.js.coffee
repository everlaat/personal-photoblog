window.Controllers ?= {}
class window.Controllers.Posts
  index: () ->
    @initLightbox()
    @initPosts()
    @initMap()

  addImagesToMap: ->
    images = []
    for post in @posts
      for image in post.getImages()
        image.post = post
        images.push image
    @map.addImages images

  initLightbox: =>
    @lightbox = new Views.Lightbox(document.querySelector '.lightbox')

  initPosts: ->
    @posts = []
    for element in document.querySelectorAll '.js--post'
      post = new Views.Post(element)
      @posts.push post
      post.on 'post.openimageset', (data) =>
        @lightbox.openImageSet data.images, data.index || 0
      post.on 'inviewport.change', (data) =>
        if data.inViewport
          @updateHash data.id

  initMap: ->
    @map = new Views.Map(document.querySelector '.js--map')
    @addImagesToMap()

  updateHash: (id) ->
    history.pushState {}, '', "#{window.location.origin}##{id}"
