window.App ?= {}
class window.App.View

  on: (eventName, callback) =>
    @events ?= {}
    @events[ eventName ] ?= []
    @events[ eventName ].push( callback )

  emit: (eventName, data = {}) =>
    if typeof @events == 'undefined' || typeof @events[ eventName ] == 'undefined'
      return null
    for callback in @events[ eventName ]
      callback(data)
