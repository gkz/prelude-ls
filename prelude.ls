# This is low level LiveScript - this is not an
# example of how you should write LiveScript.
# Code reuse has taken a back seat to performance,
# because the functions in this libaray will be
# called often, and the code here, once set, will
# not change often.

export obj-to-func = (obj) -> (obj.)

export each = (f, xs) -->
  if typeof! xs is \Object
    for , x of xs then f x
  else
    for x in xs then f x
  xs

export map = (f, xs) -->
  f = obj-to-func f if typeof! f isnt \Function
  type = typeof! xs
  if type is \Object
    {[key, f x] for key, x of xs}
  else
    result = [f x for x in xs]
    if type is \String then result.join '' else result

export filter = (f, xs) -->
  f = obj-to-func f if typeof! f isnt \Function
  type = typeof! xs
  if type is \Object
    {[key, x] for key, x of xs when f x}
  else
    result = [x for x in xs when f x]
    if type is \String then result.join '' else result

export compact = (xs) -->
  f = obj-to-func f if typeof! f isnt \Function
  type = typeof! xs
  if type is \Object
    {[key, x] for key, x of xs when x}
  else
    result = [x for x in xs when x]
    if type is \String then result.join '' else result

export reject = (f, xs) -->
  f = obj-to-func f if typeof! f isnt \Function
  type = typeof! xs
  if type is \Object
    {[key, x] for key, x of xs when not f x}
  else
    result = [x for x in xs when not f x]
    if type is \String then result.join '' else result

export partition = (f, xs) -->
  f = obj-to-func f if typeof! f isnt \Function
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

export find = (f, xs) -->
  f = obj-to-func f if typeof! f isnt \Function
  if typeof! xs is \Object
    for , x of xs when f x then return x
  else
    for x in xs when f x then return x
  void

export head = export first = (xs) ->
  return void unless xs.length
  xs.0

export tail = (xs) ->
  return void unless xs.length
  xs.slice 1

export last = (xs) ->
  return void unless xs.length
  xs[*-1]

export initial = (xs) ->
  return void unless xs.length
  xs.slice 0 (xs.length - 1)

export empty = (xs) ->
  if typeof! xs is \Object
    for x of xs then return false
    return yes
  not xs.length

export values = (obj) ->
  [x for , x of obj]

export keys = (obj) ->
  [x for x of obj]

export len = (xs) ->
  xs = values xs if typeof! xs is \Object
  xs.length

export join = (sep, xs) -->
  xs = values xs if typeof! xs is \Object
  xs.join sep

export split = (sep, xs) -->
  xs = values xs if typeof! xs is \Object
  xs.split sep

export reverse = (xs) ->
  if typeof! xs is \String
  then xs.split '' .reverse!.join ''
  else xs.slice!.reverse!

export unique = (xs) ->
  result = []
  if typeof! xs is \Object
    for , x of xs when x not in result then result.push x
  else
    for x   in xs when x not in result then result.push x
  if typeof! xs is \String then result.join '' else result

export concat = (xss) -> fold (++), [], xss

export concat-map = (f, xs) -->
  map f, xs |> concat

export flatten = (xs) -->
  xs = values xs if typeof! xs is \Object
  concat [(if typeof! x in <[ Array Arguments ]> then flatten x else x) for x in xs]

export difference = ([xs, ...yss]) ->
  results = []
  :outer for x in xs
    for ys in yss
      continue outer if x in ys
    results.push x
  results

export intersection = ([xs, ...yss]) ->
  results = []
  :outer for x in xs
    for ys in yss
      continue outer unless x in ys
    results.push x
  results

export union = (xss) ->
  unique concat xss

export count-by = (f, xs) -->
  results = {}
  for x in xs
    key = f x
    if key of results
      results[key] += 1
    else
      results[key] = 1
  results

export group-by = (f, xs) -->
  results = {}
  for x in xs
    key = f x
    if key of results
      results[key].push x
    else
      results[key] = [x]
  results

export fold = export foldl = (f, memo, xs) -->
  if typeof! xs is \Object
    for , x of xs then memo = f memo, x
  else
    for x in xs then memo = f memo, x
  memo

export fold1 = export foldl1 = (f, xs) --> fold f, xs.0, xs.slice 1

export foldr = (f, memo, xs) --> fold f, memo, xs.slice!.reverse!

export foldr1 = (f, xs) -->
  xs.=slice!.reverse!
  fold f, xs.0, xs.slice 1

export unfoldr = export unfold = (f, b) -->
  if (f b)?
    [that.0] ++ (unfoldr f, that.1)
  else
    []

export and-list = (xs) ->
  for x in xs when not x
    return false
  true

export or-list = (xs) ->
  for x in xs when x
    return true
  false

export any = (f, xs) -->
  f = obj-to-func f if typeof! f isnt \Function
  for x in xs when f x
    return yes
  no

export all = (f, xs) -->
  f = obj-to-func f if typeof! f isnt \Function
  for x in xs when not f x
    return no
  yes

export compare = (f, x, y) -->
  | (f x) > (f y) =>  1
  | (f x) < (f y) => -1
  | otherwise     =>  0

export sort = (xs) ->
  xs.concat!.sort (x, y) ->
    | x > y =>  1
    | x < y => -1
    | _     =>  0

export sort-with = (f, xs) -->
  return [] unless xs.length
  xs.concat!.sort f

export sort-by = (f, xs) -->
  return [] unless xs.length
  xs.concat!.sort (compare f)

export sum = (xs) ->
  result = 0
  if typeof! xs is \Object
    for , x of xs then result += x
  else
    for x   in xs then result += x
  result

export product = (xs) ->
  result = 1
  if typeof! xs is \Object
    for , x of xs then result *= x
  else
    for x   in xs then result *= x
  result

export mean = export average = (xs) -> (sum xs) / len xs

export list-to-obj = (xs) ->
  {[x.0, x.1] for x in xs}

export maximum = (xs) -> fold1 (>?), xs

export minimum = (xs) -> fold1 (<?), xs

export scan = export scanl = (f, memo, xs) -->
  last = memo
  if typeof! xs is \Object
  then [memo] ++ [last = f last, x for , x of xs]
  else [memo] ++ [last = f last, x for x in xs]

export scan1 = export scanl1 = (f, xs) --> scan f, xs.0, xs.slice 1

export scanr = (f, memo, xs) -->
  xs.=slice!.reverse!
  scan f, memo, xs .reverse!

export scanr1 = (f, xs) -->
  xs.=slice!.reverse!
  scan f, xs.0, xs.slice 1 .reverse!

export replicate = (n, x) -->
  result = []
  i = 0
  while i < n, ++i then result.push x
  result

export take = (n, xs) -->
  | n <= 0
    if typeof! xs is \String then '' else []
  | not xs.length => xs
  | otherwise     => xs.slice 0, n

export drop = (n, xs) -->
  | n <= 0        => xs
  | not xs.length => xs
  | otherwise     => xs.slice n

export split-at = (n, xs) --> [(take n, xs), (drop n, xs)]

export take-while = (p, xs) -->
  return xs unless xs.length
  p = obj-to-func p if typeof! p isnt \Function
  result = []
  for x in xs
    break unless p x
    result.push x
  if typeof! xs is \String then result.join '' else result

export drop-while = (p, xs) -->
  return xs unless xs.length
  p = obj-to-func p if typeof! p isnt \Function
  i = 0
  for x in xs
    break unless p x
    ++i
  drop i, xs

export span = (p, xs) --> [(take-while p, xs), (drop-while p, xs)]

export break-it = (p, xs) --> span (not) << p, xs

export zip = (xs, ys) -->
  result = []
  for zs, i in [xs, ys]
    for z, j in zs
      result.push [] if i is 0
      result[j]?push z
  result

export zip-with = (f,xs, ys) -->
  f = obj-to-func f if typeof! f isnt \Function
  if not xs.length or not ys.length
    []
  else
    [f.apply this, zs for zs in zip.call this, xs, ys]

export zip-all = (...xss) ->
  result = []
  for xs, i in xss
    for x, j in xs
      result.push [] if i is 0
      result[j]?push x
  result

export zip-all-with = (f, ...xss) ->
  f = obj-to-func f if typeof! f isnt \Function
  if not xss.0.length or not xss.1.length
    []
  else
    [f.apply this, xs for xs in zip-all.apply this, xss]

export curry = (f) ->
  curry$ f # using util method curry$ from livescript

export id = (x) -> x

export flip = (f, x, y) --> f y, x

export fix = (f) ->
  ( (g, x) -> -> f(g g) ...arguments ) do
    (g, x) -> -> f(g g) ...arguments

export lines = (str) ->
  return [] unless str.length
  str / \\n

export unlines = (.join '\n')

export words = (str) ->
  return [] unless str.length
  str / /[ ]+/

export unwords = (.join ' ')

export chars = (.split '')

export unchars = (.join '')

export max = (>?)

export min = (<?)

export negate = (x) -> -x

export abs = Math.abs

export signum = (x) ->
  | x < 0     => -1
  | x > 0     =>  1
  | otherwise =>  0

export quot = (x, y) --> ~~(x / y)

export rem = (%)

export div = (x, y) --> Math.floor x / y

export mod = (%%)

export recip = (1 /)

export pi = Math.PI

export tau = pi * 2

export exp = Math.exp

export sqrt = Math.sqrt

# changed from log as log is a
# common function for logging things
export ln = Math.log

export pow = (^)

export sin = Math.sin

export tan = Math.tan

export cos = Math.cos

export asin = Math.asin

export acos = Math.acos

export atan = Math.atan

export atan2 = (x, y) --> Math.atan2 x, y

# sinh
# tanh
# cosh
# asinh
# atanh
# acosh

export truncate = (x) -> ~~x

export round = Math.round

export ceiling = Math.ceil

export floor = Math.floor

export is-it-NaN = (x) -> x isnt x

export even = (x) -> x % 2 == 0

export odd = (x) -> x % 2 != 0

export gcd = (x, y) -->
  x = Math.abs x
  y = Math.abs y
  until y is 0
    z = x % y
    x = y
    y = z
  x

export lcm = (x, y) -->
  Math.abs Math.floor (x / (gcd x, y) * y)

# meta
export install-prelude = !(target) ->
  unless target.prelude?is-installed
    target <<< out$ # using out$ generated by livescript
    target <<< target.prelude.is-installed = true

export prelude = out$
