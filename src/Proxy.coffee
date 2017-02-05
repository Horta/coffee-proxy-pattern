# Based on https://github.com/wkf/proxy-class

_parse_methods = (proxy) ->
  for own name of Object.getPrototypeOf(@)
    value = @[name]
    if value instanceof Function
      value = proxy.forward_call.bind
        context: @,
        wrapped: value,
        name: "@#{name}"
    proxy[name] = value


class Proxy
  constructor: (obj, forward_call = @forward_call) ->
    console.log "HORTA: Proxy instantiation"
    f = _parse_methods.bind(obj, this)
    f()
    this

  forward_call: ->
    @wrapped.apply(@context, arguments)

module.exports = Proxy
