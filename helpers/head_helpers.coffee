@stylesheet = (fileName) ->
  normalizeUrl = (url, ext, root='') ->
    url += ext if url.substr(-ext.length) isnt ext
    if url[0] is '/' or /https?\:\/\//.test url
      url
    else
      "/#{root}#{url}"
  fileName = normalizeUrl fileName, '.css', 'stylesheets/'
  link href: fileName, rel: "stylesheet", type: "text/css"

@javascript = (fileName) ->
  normalizeUrl = (url, ext, root='') ->
    url += ext if url.substr(-ext.length) isnt ext
    if url[0] is '/' or /https?\:\/\//.test url
      url
    else
      "/#{root}#{url}"
  fileName = normalizeUrl fileName, '.js', 'javascripts/'
  script src: fileName, type: "text/javascript"