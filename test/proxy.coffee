Proxy = require("../lib/proxy")

class Example1
  method1: () ->
    1

  method2: () ->
    2

class Example1Proxy extends Proxy
  constructor: (obj) ->
    super(obj)

  wrap: () ->
    super() + 1

exports.setUp = (callback) ->
  callback()

exports.example1 = (test) ->

  e = new Example1()

  test.equal e.method1(), 1
  test.equal e.method2(), 2

  p = new Example1Proxy(new Example1())

  test.equal p.method1(), 2
  test.equal p.method2(), 3

  test.done()
