{spawn, exec} = require \child_process

LiveScript = require \LiveScript

# ANSI Terminal Colors.
bold  = '\33[0;1m'
red   = '\33[0;31m'
green = '\33[0;32m'
reset = '\33[0m'

tint = (text, color ? green) -> color + text + reset

slobber = (path, code) ->
  spit path, code
  say '* ' + path

minify = ->
  {parser, uglify} = require \uglify-js
  ast = parser.parse it
  ast = uglify.ast_mangle  ast
  ast = uglify.ast_squeeze ast
  uglify.gen_code ast

build = ({browser, min} || {}) ->
  ls = "\n#{slurp \prelude.ls .replace /\n/g '\n ' }\n"
  js = "#{ LiveScript.compile ls, {+bare}}"
  name = \prelude
  name += \-browser if browser
  name += \-min if min

  if browser 
    js = """
    this.prelude = function(){
      exports = {};
      #{ js }
      return exports;
    }();
    """
  slobber "#{name}.js" """
    // prelude.ls 0.6.0
    // Copyright (c) 2012 George Zahariev
    // Released under the MIT License
    // raw.github.com/gkz/prelude-ls/master/LICNSE
    #{ if min then minify js else js}
  """

task \build 'build prelude.js from prelude.ls' ->
  build!

task \build:browser 'build prelude-min.js' ->
  build {+browser}
  build {+browser, +min}

task \build:all 'build prelude.js, build prelude-min.js, and test' ->
  invoke \build
  invoke \build:browser
  invoke \test

task \test 'run test/' -> runTests!

function runTests
  global.LiveScript = LiveScript
  startTime = Date.now!
  passedTests = failedTests = 0
  for name, func of require \assert then let
    global[name] = -> func ...; ++passedTests
  global <<<
    eq: strictEqual
    throws: (msg, fun) ->
      try do fun catch return eq e?message, msg
      ok false "should throw: #msg"
  process.on \exit ->
    time = ((Date.now! - startTime) / 1e3)toFixed 2
    message = "passed #passedTests tests in #time seconds"
    say if failedTests
    then tint "failed #failedTests and #message" red
    else tint message
  code = slurp \prelude.ls
  code += slurp filename = path.join \test.ls
  try LiveScript.run code, {filename} catch
    ++failedTests
    return say e unless stk = e?stack
    msg = e.message or ''+ /^[^]+?(?=\n    at )/exec stk
    if m = /^(AssertionError:) "(.+)" (===) "(.+)"$/exec msg
      for i in [2 4] then m[i] = tint m[i]replace(/\\n/g \\n), bold 
      msg  = m.slice(1)join \\n
    [, row, col]? = //#filename:(\d+):(\d+)\)?$//m.exec stk
    if row and col
      say tint "#msg\n#{red}at #filename:#{row--}:#{col--}" red
      code = LiveScript.compile code, {+bare}
    else if /\bon line (\d+)\b/exec msg
      say tint msg, red
      row = that.1 - 1
      col = 0
    else return say stk
    {(row): line} = lines = code.split \\n
    lines[row] = line.slice(0 col) + tint line.slice(col), bold
    say lines.slice(row-8 >? 0, row+9)join \\n
