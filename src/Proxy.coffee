# Source-code: https://github.com/wkf/proxy-class

class Proxy
  constructor: (obj, wrap = @wrap) ->

    for own name, value of Object.getPrototypeOf(obj)
      if value instanceof Function
        value = wrap.bind
          context: obj,
          wrapped: value,
          name: "@#{name}",
          constructor: @constructor
      this[name] = value

    return this

  wrap: ->
    @wrapped.apply(@context, arguments)

module.exports = Proxy
