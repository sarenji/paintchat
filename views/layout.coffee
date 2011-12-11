doctype 5
html ->
  head ->
    stylesheet 'main'
    javascript 'paintchat'
    title @title or "paintchat"
  body ->
    @body