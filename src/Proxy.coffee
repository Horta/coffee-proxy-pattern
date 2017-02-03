# Source-code: https://github.com/wkf/proxy-class

class Proxy
  constructor: (obj, forward_call = @forward_call) ->

    for own name, value of Object.getPrototypeOf(obj)
      if value instanceof Function
        value = forward_call.bind
          context: obj,
          wrapped: value,
          name: "@#{name}",
          constructor: @constructor
      this[name] = value

    return this

  forward_call: ->
    @wrapped.apply(@context, arguments)

module.exports = Proxy
