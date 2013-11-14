{Model} = require 'telepath'
television = require '../../src/television'

describe "TextBinding", ->
  [tv, Blog] = []

  beforeEach ->
    class Blog extends Model
    tv = television()

  it "replaces the bound element's text content with the value of the bound property", ->
    Blog.property 'title'
    tv.register 'Blog', content: ->
      @div => @h1 'x-bind-text': "title"

    blog = Blog.createAsRoot(title: "Alpha")
    node = tv.visualize(blog)
    expect(node.outerHTML).toBe '<div><h1 x-bind-text="title">Alpha</h1></div>'
    blog.title = "Beta"
    expect(node.outerHTML).toBe '<div><h1 x-bind-text="title">Beta</h1></div>'