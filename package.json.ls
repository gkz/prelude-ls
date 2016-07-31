name: 'prelude-ls'
version: '1.1.2'

author: 'George Zahariev <z@georgezahariev.com>'

description: "prelude.ls is a functionally oriented utility library. It is powerful and flexible. Almost all of its functions are curried. It is written in, and is the recommended base library for, LiveScript."

keywords:
  'prelude'
  'livescript'
  'utility'
  'ls'
  'coffeescript'
  'javascript'
  'library'
  'functional'
  'array'
  'list'
  'object'
  'string'

main: 'lib/'
files:
  'lib/'
  'README.md'
  'LICENSE'

homepage: 'http://preludels.com'
bugs: 'https://github.com/gkz/prelude-ls/issues'
license: 'MIT'
engines:
  node: '>= 0.8.0'
repository:
  type: 'git'
  url: 'git://github.com/gkz/prelude-ls.git'
scripts:
  test: "make test"

dev-dependencies:
  livescript: '~1.5.0'
  'uglify-js': '~2.7.0'
  mocha: '~2.5.3'
  istanbul: '~0.4.4'
  browserify: '~13.1.0'
  sinon: '~1.17.5'
