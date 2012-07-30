# This is low level LiveScript - this is not an 
# example of how you should write LiveScript. 
# Code reuse has taken a back seat to performance,
# becuase the functions in this libaray will be 
# called often, and the code here, once set, will
# not change often. 

exports.objToFunc = objToFunc = (obj) ->
  (key) -> obj[key]

exports.each = each = (f, xs) -->
  if typeof! xs is \Object
    for , x of xs then f x
  else
    for x in xs then f x
  xs

exports.map = map = (f, xs) -->
  f = objToFunc f if typeof! f isnt \Function
  type = typeof! xs
  if type is \Object
    {[key, f x] for key, x of xs}
  else
    result = [f x for x in xs]
    if type is \String then result.join '' else result

exports.filter = filter = (f, xs) -->
  f = objToFunc f if typeof! f isnt \Function
  type = typeof! xs
  if type is \Object
    {[key, x] for key, x of xs when f x}
  else
    result = [x for x in xs when f x]
    if type is \String then result.join '' else result

exports.reject = reject = (f, xs) -->
  f = objToFunc f if typeof! f isnt \Function
  type = typeof! xs
  if type is \Object
    {[key, x] for key, x of xs when not f x}
  else
    result = [x for x in xs when not f x]
    if type is \String then result.join '' else result

exports.partition = partition = (f, xs) -->
  f = objToFunc f if typeof! f isnt \Function
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
      (if f x then passed else failed)push x
    if type is \String
      passed.=join ''
      failed.=join ''
  [passed, failed]

exports.find = find = (f, xs) -->
  f = objToFunc f if typeof! f isnt \Function
  if typeof! xs is \Object
    for , x of xs when f x then return x
  else
    for x in xs when f x then return x
  void

exports.head = head = exports.first = first = (xs) ->
  return void if not xs.length
  xs.0

exports.tail = tail = (xs) ->
  return void if not xs.length
  xs.slice 1

exports.last = last = (xs) ->
  return void if not xs.length
  xs[*-1]

exports.initial = initial = (xs) ->
  return void if not xs.length
  xs.slice 0, xs.length - 1

exports.empty = empty = (xs) ->
  if typeof! xs is \Object
    for x of xs then return false
    return true
  not xs.length

exports.values = values = (obj) ->
  [x for , x of obj]

exports.keys = keys = (obj) ->
  [x for x of obj]

exports.length = length = (xs) ->
  xs = values xs if typeof! xs is \Object
  xs.length

exports.cons = cons = (x, xs) -->
  if typeof! xs is \String then x + xs else [x] +++ xs

exports.append = append = (xs, ys) -->
  if typeof! ys is \String then xs + ys else xs +++ ys

exports.join = join = (sep, xs) -->
  xs = values xs if typeof! xs is \Object
  xs.join sep

exports.reverse = reverse = (xs) ->
  if typeof! xs is \String
  then xs.split '' .reverse!join ''
  else xs.slice!reverse!

exports.fold = fold = exports.foldl = foldl = (f, memo, xs) -->
  if typeof! xs is \Object
    for , x of xs then memo = f memo, x
  else
    for x in xs then memo = f memo, x
  memo

exports.fold1 = fold1 = exports.foldl1 = foldl1 = (f, xs) --> fold f, xs.0, xs.slice 1

exports.foldr = foldr = (f, memo, xs) --> fold f, memo, xs.reverse!

exports.foldr1 = foldr1 = (f, xs) -->
  xs.reverse!
  fold f, xs.0, xs.slice 1

exports.unfoldr = exports.unfold = unfoldr = (f, b) -->
  if (f b)?
    [that.0] +++ unfoldr f, that.1
  else
    []

exports.andList = andList = (xs) -> fold ((memo, x) -> memo and x), true, xs

exports.orList = orList = (xs) -> fold ((memo, x) -> memo or x), false, xs

exports.any = any = (f, xs) -->
  f = objToFunc f if typeof! f isnt \Function
  fold ((memo, x) -> memo or f x), false, xs

exports.all = all = (f, xs) -->
  f = objToFunc f if typeof! f isnt \Function
  fold ((memo, x) -> memo and f x), true, xs

exports.unique = unique = (xs) ->
  result = []
  if typeof! xs is \Object
    for , x of xs when x not in result then result.push x
  else
    for x   in xs when x not in result then result.push x
  if typeof! xs is \String then result.join '' else result

exports.sort = sort = (xs) ->
  xs.concat!sort (x, y) ->
    | x > y =>  1
    | x < y => -1
    | _     =>  0

exports.sortBy = sortBy = (f, xs) -->
  return [] unless xs.length
  xs.concat!sort f

exports.compare = compare = (f, x, y) -->
  | (f x) > (f y) =>  1
  | (f x) < (f y) => -1
  | otherwise     =>  0

exports.sum = sum = (xs) ->
  result = 0
  if typeof! xs is \Object
    for , x of xs then result += x
  else
    for x   in xs then result += x
  result

exports.product = product = (xs) ->
  result = 1
  if typeof! xs is \Object
    for , x of xs then result *= x
  else
    for x   in xs then result *= x
  result

exports.mean = mean = exports.average = average = (xs) -> (sum xs) / length xs

exports.concat = concat = (xss) -> fold append, [], xss

exports.concatMap = concatMap = (f, xs) --> concat map f, xs

exports.listToObj = listToObj = (xs) ->
  result = {}
  for x in xs
    result[x[0]] = x[1]
  result

exports.maximum = maximum = (xs) ->
  fold1 max, xs

exports.minimum = minimum = (xs) ->
  fold1 min, xs

exports.scan = scan = exports.scanl = scanl = (f, memo, xs) -->
  last = memo
  if typeof! xs is \Object
  then [memo] +++ [last = f last, x for , x of xs]
  else [memo] +++ [last = f last, x for x in xs]

exports.scan1 = scan1 = exports.scanl1 = scanl1 = (f, xs) --> scan f, xs.0, xs.slice 1

exports.scanr = scanr = (f, memo, xs) -->
  xs.reverse!
  scan f, memo, xs .reverse!

exports.scanr1 = scanr1 = (f, xs) -->
  xs.reverse!
  scan f, xs.0, xs.slice 1 .reverse!

exports.replicate = replicate = (n, x) -->
  result = []
  i = 0
  while i < n, ++i then result.push x
  result

exports.take = take = (n, xs) -->
  | n <= 0
    if typeof! xs is \String then '' else []
  | not xs.length => xs
  | otherwise     => xs.slice 0, n

exports.drop = drop = (n, xs) -->
  | n <= 0        => xs
  | not xs.length => xs
  | otherwise     => xs.slice n

exports.splitAt = splitAt = (n, xs) --> [(take n, xs), (drop n, xs)]

exports.takeWhile = takeWhile = (p, xs) -->
  return xs if not xs.length
  p = objToFunc p if typeof! p isnt \Function
  result = []
  for x in xs
    break if not p x
    result.push x
  if typeof! xs is \String then result.join '' else result

exports.dropWhile = dropWhile = (p, xs) -->
  return xs if not xs.length
  p = objToFunc p if typeof! p isnt \Function
  i = 0
  for x in xs
    break if not p x
    ++i
  drop i, xs

exports.span = span = (p, xs) --> [(takeWhile p, xs), (dropWhile p, xs)]

exports.breakIt = breakIt = (p, xs) --> span (not) << p, xs

exports.zip = zip = (xs, ys) -->
  result = []
  for zs, i in [xs, ys]
    for z, j in zs
      result.push [] if i is 0
      result[j]?.push z
  result

exports.zipWith = zipWith = (f,xs, ys) -->
  f = objToFunc f if typeof! f isnt \Function
  if not xs.length or not ys.length
    []
  else
    [f.apply this, zs for zs in zip.call this, xs, ys]

exports.zipAll = zipAll = (...xss) ->
  result = []
  for xs, i in xss
    for x, j in xs
      result.push [] if i is 0
      result[j]?.push x
  result

exports.zipAllWith = zipAllWith = (f, ...xss) ->
  f = objToFunc f if typeof! f isnt \Function
  if not xss.0.length or not xss.1.length
    []
  else
    [f.apply this, xs for xs in zipAll.apply this, xss]

exports.compose = compose = (...funcs) ->
  ->
    args = arguments
    for f in funcs
      args = [f.apply this, args]
    args.0

exports.curry = curry = (f) ->
  curry$ f # using util method __curry from livescript

exports.id = id = (x) -> x

exports.flip = flip = (f, x, y) --> f y, x

exports.fix = fix = (f) ->
  ( (g, x) -> -> f(g g) ...arguments ) do
    (g, x) -> -> f(g g) ...arguments

exports.lines = lines = (str) ->
  return [] if not str.length
  str.split \\n

exports.unlines = unlines = (strs) -> strs.join \\n

exports.words = words = (str) ->
  return [] if not str.length
  str.split /[ ]+/

exports.unwords = unwords = (strs) -> strs.join ' '

exports.max = max = (x, y) --> if x > y then x else y

exports.min = min = (x, y) --> if x > y then y else x

exports.negate = negate = (x) -> -x

exports.abs = abs = Math.abs

exports.signum = signum = (x) ->
  | x < 0     => -1
  | x > 0     =>  1
  | otherwise =>  0

exports.quot = quot = (x, y) --> ~~(x / y)

exports.rem = rem = (x, y) --> x % y

exports.div = div = (x, y) --> Math.floor x / y

exports.mod = mod = (x, y) --> x %% y

exports.recip = recip = (x) -> 1 / x

exports.pi = pi = Math.PI

exports.tau = tau = pi * 2

exports.exp = exp = Math.exp

exports.sqrt = sqrt = Math.sqrt

# changed from log as log is a 
# common function for logging things
exports.ln = ln = Math.log

exports.pow = pow = (x, y) --> x ^ y

exports.sin = sin = Math.sin

exports.tan = tan = Math.tan

exports.cos = cos = Math.cos

exports.asin = asin = Math.asin

exports.acos = acos = Math.acos

exports.atan = atan = Math.atan

exports.atan2 = atan2 = (x, y) --> Math.atan2 x, y

# sinh
# tanh
# cosh
# asinh
# atanh
# acosh

exports.truncate = truncate = (x) -> ~~x

exports.round = round = Math.round

exports.ceiling = ceiling = Math.ceil

exports.floor = floor = Math.floor

exports.isItNaN = isItNaN = (x) -> x isnt x

exports.even = even = (x) -> x % 2 == 0

exports.odd = odd = (x) -> x % 2 != 0

exports.gcd = gcd = (x, y) -->
  x = Math.abs x
  y = Math.abs y
  until y is 0
    z = x % y
    x = y
    y = z
  x

exports.lcm = lcm = (x, y) -->
  Math.abs Math.floor (x / (gcd x, y) * y)

# meta
exports.installPrelude = !(target) ->
  unless target.prelude?.isInstalled
    target <<< exports
    target.prelude.isInstalled = true

exports.prelude = exports
