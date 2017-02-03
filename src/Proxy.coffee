class Proxy
  constructor: (klass, wrap = @wrap) ->
    _constructor = @_buildProxyConstructor(klass, wrap)

    eval """
      this.klass = function #{klass.name}() { _constructor.apply(this, arguments) }
    """

    @_wrapClassMethods(klass, wrap)

    return @klass

  _buildProxyConstructor: (klass, wrap) ->
    ->
      for own name, value of klass::
        if value instanceof Function
          value = wrap.bind context: @, wrapped: value, name: name
        @[name] = value

      wrap.apply(
        {context: @, wrapped: klass, name: 'constructor'}, arguments)

  _wrapClassMethods: (klass, wrap) ->
    for own name, value of klass
      if value instanceof Function
        value = wrap.bind
          context: @klass,
          wrapped: value,
          name: "@#{name}",
          constructor: @constructor
      @klass[name] = value

  wrap: ->
    @wrapped.apply(@context, arguments)

module.exports = Proxy

# class Proxy
#   constructor: (@klass, wrap) ->
#     console.log("Ponto 1: #{@klass}")
#     @_wrapClassMethods wrap
#
#   _wrapClassMethods: (wrap) ->
#     console.log("Ponto 2")
#     for own name, value of @klass
#       if value instanceof Function
#         console.log("Ponto 3: #{name}")
#         value = wrap.bind
#           context: @klass,
#           wrapped: value,
#           name: "@#{name}",
#           constructor: @constructor
#       @klass[name] = value
#
# # export class Proxy
# #   constructor: (klass, wrap = @wrap) ->
# #     _constructor = @_buildProxyConstructor(klass, wrap)
# #
# #     eval """
# #       this.klass = function #{klass.name}() { _constructor.
# #         apply(this, arguments) }
# #     """
# #
# #     @_wrapClassMethods(klass, wrap)
# #
# #     return @klass
# #
#   # _buildProxyConstructor: (klass, wrap) ->
#   #   ->
#   #     for own name, value of klass::
#   #       if value instanceof Function
#   #         value = wrap.bind context: @, wrapped: value, name: name
#   #       @[name] = value
#   #
#   #     wrap.apply(
#   #       {context: @, wrapped: klass, name: 'constructor'}, arguments)
# #
# #   _wrapClassMethods: (klass, wrap) ->
# #     for own name, value of klass
# #       if value instanceof Function
# #         value = wrap.bind
# #           context: @klass,
# #           wrapped: value,
# #           name: "@#{name}",
# #           constructor: @constructor
# #       @klass[name] = value
# #
# #   wrap: ->
# #     @wrapped.apply(@context, arguments)
#
# # module.exports.create_proxy = (klass) ->
# #   proxy = new Proxy()
# #   proxy.klass = klass
# #   proxy.constructor = () ->
# #     2
# #   return proxy
#
# module.exports = Proxy
