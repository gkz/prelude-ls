name    : \prelude-ls
version : \0.3.0

description : "prelude.ls is the recommended base library for LiveScript, however it will work in any JavaScript environment. It provides a set of functions somewhat based off of Haskell's Prelude."
keywords    :
  \library
  \prelude
  \livescript
  \ls
  \coffeescript
  \javascript

author   : 'George Zahariev <z@georgezahariev.com>'
homepage : \http://gkz.github.com/prelude-ls
bugs     : \https://github.com/gkz/prelude-ls/issues
licenses :
  type: \MIT, url: \https://raw.github.com/gkz/prelude-ls/master/LICENSE
  ...

engines     : node: '>= 0.6.14 < 0.9.0'
files       : 
  \prelude.js
  \README.md
  \LICENSE

main : \./prelude.js

repository: type: \git, url: \git://github.com/gkz/prelude-ls.git
