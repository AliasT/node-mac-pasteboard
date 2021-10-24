const pasteboard = require('bindings')('pasteboard.node')

console.log(pasteboard.Get().toString())
