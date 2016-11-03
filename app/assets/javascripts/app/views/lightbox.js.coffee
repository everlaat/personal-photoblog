window.Views ?= {}
class window.Views.Lightbox
  constructor: (@el) ->
    @imagesetEl = @el.querySelector '.lightbox__imageset'
    @imagesetIndexEl = @el.querySelector '.lightbox__imagesetIndex'
    for closeEl in @el.querySelectorAll '[data-close]'
      closeEl.addEventListener 'click', (el) =>
        @setInactive()


  openImageSet: (images, index = 0) =>
    @setActive()
    @setImageset images
    setTimeout( =>
      @setActiveImage index, true
    , 200)

  clearImageset: =>
    @imageset = []
    @imagesetEl.innerHTML = ''
    @imagesetIndexEl.innerHTML = ''

  setImageset: (images) =>
    @clearImageset()
    @imageset = images
    index = 0
    prev = elem 'li.prev'
    prev.addEventListener 'click', @onPrevClick
    next = elem 'li.next'
    next.addEventListener 'click', @onNextClick
    @imagesetIndexEl.appendChild prev
    for image in images
      li = elem 'li.index',
        style: "background-image: url(#{image.url});",
        'data-index': index
      liimg = elem 'li.image',
        #style: "background-image: url(#{image.url});",
        'data-index': index
      img = elem 'img',
        src: image.url
      liimg.appendChild img

      @imagesetIndexEl.appendChild li
      @imagesetEl.appendChild liimg
      li.addEventListener 'mouseenter', @onIndexClick
      li.addEventListener 'click', @onIndexClick
      index++
    @imagesetIndexEl.appendChild next

  setActiveImage: (index) =>
    @activeIndex = index
    li = @imagesetEl.querySelector "[data-index=\"#{index}\"]"
    padding = window.innerWidth - li.clientWidth
    left = li.offsetLeft - (padding / 2)
    transform = "transform: translate(#{0-left}px, 0);"
    @imagesetEl.setAttribute 'style', transform
    for el in @imagesetIndexEl.querySelectorAll('li')
      el.classList.remove 'is--active'
    el = @imagesetIndexEl.querySelector "[data-index=\"#{index}\"]"
    el.classList.add 'is--active'

  onIndexClick: (ev) =>
    index = ev.currentTarget.dataset.index
    @setActiveImage index

  onPrevClick: (ev) =>
    if @activeIndex > 0
      @setActiveImage @activeIndex - 1

  onNextClick: (ev) =>
    total = @imageset.length
    if @activeIndex < @imageset.length - 1
      @setActiveImage @activeIndex + 1

  setActive: () =>
    @el.classList.add 'is--active'
    setTimeout( =>
      @el.classList.add 'fade-in'
    )

  setInactive: () =>
    @el.classList.remove 'fade-in'
    setTimeout( =>
      @el.classList.remove 'is--active'
    , 300)

  elem = (elemStr, attributes = {}) ->
    elemArr = elemStr.split '.'
    el = document.createElement elemArr.shift()
    while elemArr.length > 0
      el.classList.add elemArr.shift()
    for k, v of attributes
      el.setAttribute k, v
    el
