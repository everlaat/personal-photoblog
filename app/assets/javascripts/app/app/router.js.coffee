window.App ?= {}
class window.App.Routes

  location = window.location
  paths = {}
  currentPath = null

  constructor: ->

  init: =>
    path = location.pathname || '/'
    if typeof paths[ path ] != 'undefined'
      return @goto paths[ path ]

  goto: (obj) ->
    currentPath = new obj.controller()
    if typeof obj.action != 'undefined'
      currentPath[ obj.action ]()
    else
      currentPath.index()


  path: (path, to) ->
    if typeof paths[ path ] != 'undefined'
      throw new Error "path #{path} already set!"
    paths[ path ] = to
    @

  root: (to) ->
    @path '/', to

  list: ->
    paths
