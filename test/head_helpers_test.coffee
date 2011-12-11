coffeekup = require 'coffeekup'
helpers   = require '../helpers'
should    = require 'should'
template  = ""

jsdom     = require 'jsdom'
fs        = require 'fs'
jquery    = fs.readFileSync("./public/javascripts/jquery-1.7.1.js").toString()

render = (done, callback) ->
  rendered = coffeekup.render template, hardcode: helpers
  jsdom.env
    html     : rendered
    src      : [ jquery ]
    done     : (errors, window) ->
      callback.call window, window, window.$, rendered
      done()

describe 'a stylesheet helper', ->
  it "should have the proper metadata", (done) ->
    template = -> stylesheet ''
    render done, (window, $, template) ->
      $template = $(template)
      $template[0].tagName.toLowerCase().should.equal 'link'
      $template.attr('type').should.equal 'text/css'
      $template.attr('rel').should.equal 'stylesheet'

  it "should render different domains correctly", (done) ->
    template = -> stylesheet 'http://example.com/foo.css'
    render done, (window, $, template) ->
      $template = $(template)
      $template.attr('href').should.equal 'http://example.com/foo.css'

  it "should render simple relative paths correctly", (done) ->
    template = -> stylesheet 'foo'
    render done, (window, $, template) ->
      $template = $(template)
      $template.attr('href').should.equal '/stylesheets/foo.css'

  it "should render complex relative paths correctly", (done) ->
    template = -> stylesheet '../foo'
    render done, (window, $, template) ->
      $template = $(template)
      $template.attr('href').should.equal '/stylesheets/../foo.css'

  it "should render absolute paths correctly", (done) ->
    template = -> stylesheet '/foo'
    render done, (window, $, template) ->
      $template = $(template)
      $template.attr('href').should.equal '/foo.css'


describe 'a javascript helper', ->
  it "should have the proper metadata", (done) ->
    template = -> javascript ''
    render done, (window, $, template) ->
      $template = $(template)
      $template[0].tagName.toLowerCase().should.equal 'script'
      $template.attr('type').should.equal 'text/javascript'

  it "should render different domains correctly", (done) ->
    template = -> javascript 'https://example.com/bar'
    render done, (window, $, template) ->
      $template = $(template)
      $template.attr('src').should.equal 'https://example.com/bar.js'

  it "should render simple relative paths correctly", (done) ->
    template = -> javascript 'bar'
    render done, (window, $, template) ->
      $template = $(template)
      $template.attr('src').should.equal '/javascripts/bar.js'

  it "should render complex relative paths correctly", (done) ->
    template = -> javascript '../bar'
    render done, (window, $, template) ->
      $template = $(template)
      $template.attr('src').should.equal '/javascripts/../bar.js'

  it "should render absolute paths correctly", (done) ->
    template = -> javascript '/bar'
    render done, (window, $, template) ->
      $template = $(template)
      $template.attr('src').should.equal '/bar.js'
