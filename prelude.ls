# This is low level LiveScript - this is not an
# example of how you should write LiveScript.
# Code reuse has taken a back seat to performance,
# because the functions in this libaray will be
# called often, and the code here, once set, will
# not change often.

obj-to-func = (obj) -> (obj.)

list-to-obj = (xs) ->
  {[x.0, x.1] for x in xs}

each = (f, xs) -->
  if typeof! xs is \Object
    for , x of xs then f x
  else
    for x in xs then f x
  xs

map = (f, xs) -->
  f = obj-to-func f unless typeof! f is \Function
  type = typeof! xs
  if type is \Object
    {[key, f x] for key, x of xs}
  else
    result = [f x for x in xs]
    if type is \String then result.join '' else result

filter = (f, xs) -->
  f = obj-to-func f unless typeof! f is \Function
  type = typeof! xs
  if type is \Object
    {[key, x] for key, x of xs when f x}
  else
    result = [x for x in xs when f x]
    if type is \String then result.join '' else result

compact = (xs) -->
  if typeof! xs is \Object
    {[key, x] for key, x of xs when x}
  else
    [x for x in xs when x]

reject = (f, xs) -->
  f = obj-to-func f unless typeof! f is \Function
  type = typeof! xs
  if type is \Object
    {[key, x] for key, x of xs when not f x}
  else
    result = [x for x in xs when not f x]
    if type is \String then result.join '' else result

partition = (f, xs) -->
  f = obj-to-func f unless typeof! f is \Function
  type = typeof! xs
  if type is \Object
    passed = {}
    failed = {}
    for key, x of xs
      (if f x then passed else failed)[key] = x
  else
    passed = []
    failed = []
    for x in xs
      (if f x then passed else failed).push x
    if type is \String
      passed *= ''
      failed *= ''
  [passed, failed]

find = (f, xs) -->
  f = obj-to-func f unless typeof! f is \Function
  if typeof! xs is \Object
    for , x of xs when f x then return x
  else
    for x in xs when f x then return x
  void

head = first = (xs) ->
  return void unless xs.length
  xs.0

tail = (xs) ->
  return void unless xs.length
  xs.slice 1

last = (xs) ->
  return void unless xs.length
  xs[*-1]

initial = (xs) ->
  return void unless xs.length
  xs.slice 0 (xs.length - 1)

empty = (xs) ->
  if typeof! xs is \Object
    for x of xs then return false
    true
  else
    not xs.length

values = (obj) ->
  [x for , x of obj]

keys = (obj) ->
  [x for x of obj]

len = (xs) ->
  xs = values xs if typeof! xs is \Object
  xs.length

join = (sep, xs) -->
  xs = values xs if typeof! xs is \Object
  xs.join sep

reverse = (xs) ->
  if typeof! xs is \String
  then xs.split '' .reverse!.join ''
  else xs.concat!.reverse!

unique = (xs) ->
  result = []
  if typeof! xs is \Object
    for , x of xs when x not in result then result.push x
  else
    for x   in xs when x not in result then result.push x
  if typeof! xs is \String then result.join '' else result

fold = foldl = (f, memo, xs) -->
  if typeof! xs is \Object
    for , x of xs then memo = f memo, x
  else
    for x in xs then memo = f memo, x
  memo

fold1 = foldl1 = (f, xs) --> fold f, xs.0, xs.slice 1

foldr = (f, memo, xs) --> fold f, memo, xs.concat!.reverse!

foldr1 = (f, xs) -->
  xs.=concat!.reverse!
  fold f, xs.0, xs.slice 1

unfoldr = unfold = (f, b) -->
  if (f b)?
    [that.0] ++ (unfoldr f, that.1)
  else
    []

concat = (xss) -> fold (++), [], xss

concat-map = (f, xs) -->
  fold ((memo, x) -> memo ++ f x), [], xs

flatten = (xs) -->
  xs = values xs if typeof! xs is \Object
  concat [(if typeof! x in <[ Array Arguments ]> then flatten x else x) for x in xs]

difference = ([xs, ...yss]) ->
  results = []
  :outer for x in xs
    for ys in yss
      continue outer if x in ys
    results.push x
  results

intersection = ([xs, ...yss]) ->
  results = []
  :outer for x in xs
    for ys in yss
      continue outer unless x in ys
    results.push x
  results

union = (xss) ->
  results = []
  for xs in xss
    for x in xs
      results.push x unless x in results
  results

count-by = (f, xs) -->
  results = {}
  for x in xs
    key = f x
    if key of results
      results[key] += 1
    else
      results[key] = 1
  results

group-by = (f, xs) -->
  results = {}
  for x in xs
    key = f x
    if key of results
      results[key].push x
    else
      results[key] = [x]
  results

and-list = (xs) ->
  for x in xs when not x
    return false
  true

or-list = (xs) ->
  for x in xs when x
    return true
  false

any = (f, xs) -->
  f = obj-to-func f unless typeof! f is \Function
  for x in xs when f x
    return true
  false

all = (f, xs) -->
  f = obj-to-func f unless typeof! f is \Function
  for x in xs when not f x
    return false
  true

compare = (f, x, y) -->
  | (f x) > (f y) =>  1
  | (f x) < (f y) => -1
  | otherwise     =>  0

sort = (xs) ->
  xs.concat!.sort (x, y) ->
    | x > y =>  1
    | x < y => -1
    | _     =>  0

sort-with = (f, xs) -->
  return [] unless xs.length
  xs.concat!.sort f

sort-by = (f, xs) -->
  return [] unless xs.length
  xs.concat!.sort (compare f)

sum = (xs) ->
  result = 0
  if typeof! xs is \Object
    for , x of xs then result += x
  else
    for x   in xs then result += x
  result

product = (xs) ->
  result = 1
  if typeof! xs is \Object
    for , x of xs then result *= x
  else
    for x   in xs then result *= x
  result

mean = average = (xs) -> (sum xs) / len xs

maximum = (xs) -> fold1 (>?), xs

minimum = (xs) -> fold1 (<?), xs

scan = scanl = (f, memo, xs) -->
  last = memo
  if typeof! xs is \Object
  then [memo] ++ [last = f last, x for , x of xs]
  else [memo] ++ [last = f last, x for x in xs]

scan1 = scanl1 = (f, xs) --> scan f, xs.0, xs.slice 1

scanr = (f, memo, xs) -->
  xs.=slice!.reverse!
  scan f, memo, xs .reverse!

scanr1 = (f, xs) -->
  xs.=slice!.reverse!
  scan f, xs.0, xs.slice 1 .reverse!

replicate = (n, x) -->
  [x for from 0 til n]

take = (n, xs) -->
  if n <= 0
    if typeof! xs is \String then '' else []
  else if not xs.length
    xs
  else
    xs.slice 0, n

drop = (n, xs) -->
  if n <= 0 or not xs.length
    xs
  else
    xs.slice n

split-at = (n, xs) --> [(take n, xs), (drop n, xs)]

take-while = (p, xs) -->
  return xs unless xs.length
  p = obj-to-func p if typeof! p isnt \Function
  result = []
  for x in xs
    break unless p x
    result.push x
  if typeof! xs is \String then result.join '' else result

drop-while = (p, xs) -->
  return xs unless xs.length
  p = obj-to-func p if typeof! p isnt \Function
  i = 0
  for x in xs
    break unless p x
    ++i
  drop i, xs

span = (p, xs) --> [(take-while p, xs), (drop-while p, xs)]

break-list = (p, xs) --> span (not) << p, xs

zip = (xs, ys) -->
  result = []
  for zs, i in [xs, ys]
    for z, j in zs
      result.push [] if i is 0
      result[j]?.push z
  result

zip-with = (f,xs, ys) -->
  f = obj-to-func f unless typeof! f is \Function
  if not xs.length or not ys.length
    []
  else
    [f.apply this, zs for zs in zip.call this, xs, ys]

zip-all = (...xss) ->
  result = []
  for xs, i in xss
    for x, j in xs
      result.push [] if i is 0
      result[j]?.push x
  result

zip-all-with = (f, ...xss) ->
  f = obj-to-func f unless typeof! f is \Function
  if not xss.0.length or not xss.1.length
    []
  else
    [f.apply this, xs for xs in zip-all.apply this, xss]

curry = (f) ->
  curry$ f # using util method curry$ from livescript

id = (x) -> x

flip = (f, x, y) --> f y, x

fix = (f) ->
  ( (g, x) -> -> f(g g) ...arguments ) do
    (g, x) -> -> f(g g) ...arguments

split = (sep, str) -->
  str.split sep

lines = (str) ->
  return [] unless str.length
  str.split \\n

unlines = (.join '\n')

words = (str) ->
  return [] unless str.length
  str.split /[ ]+/

unwords = (.join ' ')

chars = (.split '')

unchars = (.join '')

max = (>?)

min = (<?)

negate = (x) -> -x

abs = Math.abs

signum = (x) ->
  | x < 0     => -1
  | x > 0     =>  1
  | otherwise =>  0

quot = (x, y) --> ~~(x / y)

rem = (%)

div = (x, y) --> Math.floor x / y

mod = (%%)

recip = (1 /)

pi = Math.PI

tau = pi * 2

exp = Math.exp

sqrt = Math.sqrt

ln = Math.log

pow = (^)

sin = Math.sin

tan = Math.tan

cos = Math.cos

asin = Math.asin

acos = Math.acos

atan = Math.atan

atan2 = (x, y) --> Math.atan2 x, y

truncate = (x) -> ~~x

round = Math.round

ceiling = Math.ceil

floor = Math.floor

is-it-NaN = (x) -> x isnt x

even = (x) -> x % 2 == 0

odd = (x) -> x % 2 != 0

gcd = (x, y) -->
  x = Math.abs x
  y = Math.abs y
  until y is 0
    z = x % y
    x = y
    y = z
  x

lcm = (x, y) -->
  Math.abs Math.floor (x / (gcd x, y) * y)

prelude = {
  each, map, filter, compact, reject, partition, find
  head, first, tail, last, initial, empty, values, keys, len
  join, split, reverse, difference, intersection, union, count-by, group-by
  fold, fold1, foldl, foldl1, foldr, foldr1, unfoldr, and-list, or-list
  any, all, unique, compare, sort, sort-with, sort-by, sum, product, mean, average
  concat, concat-map, flatten, maximum, minimum, scan, scan1, scanl, scanl1, scanr, scanr1
  replicate, take, drop, split-at, take-while, drop-while, span, break-list
  list-to-obj, obj-to-func, zip, zip-with, zip-all, zip-all-with, curry, id, flip, fix
  lines, unlines, words, unwords, chars, unchars, max, min, negate, abs, signum
  quot, rem, div, mod, recip, pi, tau, exp, sqrt, ln, pow, sin, tan
  acos, asin, atan, atan2, truncate, round, ceiling, floor
  is-it-NaN, even, odd, gcd, lcm
}
prelude.prelude = prelude

prelude.install-prelude = !(target) ->
  unless target.prelude?.is-installed
    target <<< prelude
    target <<< target.prelude.is-installed = true

exports = prelude if exports?
