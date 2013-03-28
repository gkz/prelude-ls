name    : \prelude-ls
version : \0.7.0-dev

description : "prelude.ls is a JavaScript functional programming library. It is the recommended base library for, and is written in, LiveScript. It is inspired in part by Haskell's Prelude module, and other utility libraries."
keywords    :
  \library
  \prelude
  \functional
  \array
  \utility
  \livescript
  \ls
  \coffeescript
  \javascript

author   : 'George Zahariev <z@georgezahariev.com>'
homepage : \http://gkz.github.com/prelude-ls/
bugs     : \https://github.com/gkz/prelude-ls/issues
licenses :
  type: \MIT, url: \https://raw.github.com/gkz/prelude-ls/master/LICENSE
  ...

engines     : node: '>= 0.8.0'
files       :
  \prelude.js
  \prelude-browser.js
  \prelude-browser-min.js
  \README.md
  \LICENSE

main : \./prelude.js

dev-dependencies:
  LiveScript: '~1.1.1'
  'uglify-js': '~1.3.0'

repository: type: \git, url: \git://github.com/gkz/prelude-ls.git
