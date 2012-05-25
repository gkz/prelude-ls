# This is low level LiveScript - this is not an 
# example of how you should write LiveScript. 
# Code reuse has taken a back seat to performance,
# becuase the functions in this libaray will be 
# called often, and the code here, once set, will
# not change often. 

exports.contradict = (x) -> not x

exports.equals = (x, y) --> x == y

exports.notEquals = (x, y) --> x != y

exports.lt = (x, y) --> x > y

exports.lte = (x, y) --> x >= y

exports.gt = (x, y) --> x < y

exports.gte = (x, y) --> x <= y

exports.andTest = (x, y) --> x and y

exports.orTest = (x, y) --> x or y

exports.compose = (...funcs) -> 
  ->
    args = arguments
    for f in funcs
      args = [f.apply this, args]
    args.0

exports.max = Math.max

exports.min = Math.min

exports.negate = (x) -> -x

exports.abs = Math.abs

exports.signum = (x) -> 
  | x < 0     => -1
  | x > 0     =>  1
  | otherwise =>  0

exports.quot = (x, y) --> ~~(x / y)

exports.rem = (x, y) --> x % y

exports.div = (x, y) --> Math.floor x / y

exports.mod = (x, y) --> x %% y

exports.recip = (x) -> 1 / x

exports.pi = Math.PI

exports.exp = Math.exp

exports.sqrt = Math.sqrt

exports.log = Math.log

exports.pow = (x, y) --> x ^ y

exports.sin = Math.sin

exports.tan = Math.tan

exports.cos = Math.cos

exports.asin = Math.asin

exports.atan = Math.atan

exports.atan2 = (x, y) --> Math.atan2 x, y

exports.acos = Math.acos

# sinh
# tanh
# cosh
# asinh
# atanh
# acosh

exports.truncate = (x) -> ~~x

exports.round = Math.round

exports.ceiling = Math.ceil

exports.floor = Math.floor

exports.isItNaN = (x) -> x isnt x

exports.add = (x, y) --> x + y

exports.minus = (x, y) --> x - y

exports.subtract = (x, y) --> y - x

exports.multiply = exports.times = (x, y) --> x * y

exports.divide = (x, y) --> x / y

exports.divideBy = (x, y) --> y / x

exports.even = (x) -> x % 2 == 0

exports.odd = (x) -> x % 2 != 0

exports.gcd = (x, y) --> 
  x = Math.abs x
  y = Math.abs y
  until y is 0
    z = x % y
    x = y
    y = z
  x

# depends on gcd
exports.lcm = (x, y) -->
  Math.abs Math.floor (x / (gcd x, y) * y)

exports.id = (x) -> x

exports.flip = (f, x, y) --> f y, x

exports.error = (msg) -> throw msg

exports.each = (f, xs) --> 
  for x in xs then f x
  xs

exports.map = (f, xs) --> 
  result = []
  for x in xs then result.push f x
  result

exports.cons = (x, xs) --> x & xs

exports.append = (xs, ys) --> xs +++ ys

exports.filter = (f, xs) --> 
  result = []
  for x in xs when f x then result.push x
  result

exports.reject = (f, xs) -->
  result = []
  for x in xs when not f x then result.push x
  result

exports.find = (f, xs) -->
  for x in xs when f x then return x
  void

exports.pluck = (prop, xs) -->
  result = []
  for x in xs when x[prop]? then result.push x[prop]
  result

exports.head = (xs) -> xs.slice 0, 1

exports.tail = (xs) -> xs.slice 1

exports.last = (xs) -> xs.slice xs.length - 1

exports.initial = (xs) -> xs.slice 0, xs.length - 1

exports.empty = (xs) -> not xs.length

exports.length = (xs) -> xs.length

exports.reverse = (xs) -> xs.slice!reverse!

exports.fold = exports.foldl = (f, memo, xs) -->
  for x in xs then memo = f memo, x
  memo

exports.fold1 = exports.foldl1 = (f, xs) --> fold f, xs.0, xs.slice 1

exports.foldr = (f, memo, xs) --> fold f, memo, xs.reverse!

exports.foldr1 = (f, xs) --> 
  xs.reverse!
  fold f, xs.0, xs.slice 1

exports.andList = (xs) -> fold ((memo, x) -> memo and x), true, xs

exports.orList = (xs) -> fold ((memo, x) -> memo or x), false, xs

exports.any = (f, xs) --> fold ((memo, x) -> memo or f x), false, xs

exports.all = (f, xs) --> fold ((memo, x) -> memo and f x), true, xs

exports.sum = (xs) ->
  result = 0 
  for x in xs then result += x
  result

exports.product = (xs) ->
  result = 1
  for x in xs then result *= x
  result

exports.concat = (xss) -> fold append, [], xss

exports.concatMap = (f, xs) --> concat map f, xs

exports.maximum = (xs) -> Math.max.apply(this, xs)

exports.minimum = (xs) -> Math.min.apply(this, xs)

exports.scan = exports.scanl = (f, memo, xs) --> 
  result = [memo]
  last = memo
  for x in xs
    result.push (last = f last, x)
  result


exports.scan1 = exports.scanl1 = (f, xs) --> scan f, xs.0, xs.slice 1

exports.scanr = (f, memo, xs) --> 
  xs.reverse!
  scan f, memo, xs .reverse!

exports.scanr1 = (f, xs) -->
  xs.reverse!
  scan f, xs.0, xs.slice 1 .reverse!

exports.replicate = (n, x) --> 
  result = []
  i = 0
  while i < n, ++i then result.push x
  result

exports.take = (n, xs) -->
  | n <= 0        => xs
  | not xs.length => []
  | otherwise     => xs.slice 0, n

exports.drop = (n, xs) -->
  | n <= 0        => xs
  | not xs.length => []
  | otherwise     => xs.slice n

exports.splitAt = (n, xs) --> [(take n, xs), (drop n, xs)]

exports.takeWhile = (p, xs) -->
  return [] if not xs.length
  i = 0
  for x in xs
    break if not p x
    ++i
  take i, xs

exports.dropWhile = (p, xs) -->
  return [] if not xs.length
  i = 0
  for x in xs
    break if not p x
    ++i
  drop i, xs

exports.span = (p, xs) --> [(takeWhile p, xs), (dropWhile p, xs)]

exports.breakList = (p, xs) --> span (contradict << p), xs

exports.elem = (x, ys) --> x in ys

exports.notElem = (x, ys) --> x not in ys

exports.lookup = (key, xs) --> xs?[key]

exports.zip = (...xss) -> 
  result = []
  for xs, i in xss
    for x, j in xs
      result.push [] if i is 0  
      result[j]?.push x
  result

exports.zipWith = (f, ...xss) ->
  if not xss.0.length or not xss.1.length
    []
  else
    result = []
    for xs in zip.apply(this, xss) then result.push f.apply(this, xs) 
    result

# string

exports.lines = (str) -> str.split \\n

exports.unlines = (str) -> str.join \\n

exports.words = (str) -> str.split ' '

exports.unwords = (str) -> str.join ' '
