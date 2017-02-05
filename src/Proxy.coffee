# Based on https://github.com/wkf/proxy-class

_parse_methods = (proxy) ->
  console.log "Proxy: _parse_methods"
  for own name of Object.getPrototypeOf(@)
    console.log "Proxy: _parse_methods:#{name}"
    value = @[name]
    if value instanceof Function
      value = proxy.forward_call.bind
        context: @,
        wrapped: value,
        name: "@#{name}",
        constructor: @constructor,
        length: value.length
    proxy[name] = value


class Proxy
  constructor: (obj, forward_call = @forward_call) ->
    console.log "Proxy: constructor"
    _parse_methods.bind(obj, this)()

  forward_call: ->
    @wrapped.apply(@context, arguments)

module.exports = Proxy
