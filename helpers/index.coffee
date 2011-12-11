path       = require 'path'
{globSync} = require 'glob'

helpers = {}
helperPaths = [
  "helpers/**/*.coffee"
]

coffeekup = require 'coffeekup'
for globPath in helperPaths
  for fileName in globSync globPath
    hash = require path.join process.cwd(), fileName
    for helper, func of hash
      if helper not of helpers then helpers[helper] = func

module.exports = helpers