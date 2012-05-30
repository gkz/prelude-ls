# This is low level LiveScript - this is not an 
# example of how you should write LiveScript. 
# Code reuse has taken a back seat to performance,
# becuase the functions in this libaray will be 
# called often, and the code here, once set, will
# not change often. 

exports.compose = compose = (...funcs) -> 
  ->
    args = arguments
    for f in funcs
      args = [f.apply this, args]
    args.0

exports.max = max = (x, y) --> Math.max x, y

exports.min = min = (x, y) --> Math.min x, y

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

exports.exp = exp = Math.exp

exports.sqrt = sqrt = Math.sqrt

exports.log = log = Math.log

exports.pow = pow = (x, y) --> x ^ y

exports.sin = sin = Math.sin

exports.tan = tan = Math.tan

exports.cos = cos = Math.cos

exports.asin = asin = Math.asin

exports.atan = atan = Math.atan

exports.atan2 = atan2 = (x, y) --> Math.atan2 x, y

exports.acos = acos = Math.acos

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

# depends on gcd
exports.lcm = lcm = (x, y) -->
  Math.abs Math.floor (x / (gcd x, y) * y)

exports.id = id = (x) -> x

exports.flip = flip = (f, x, y) --> f y, x

exports.error = error = (msg) -> throw msg

exports.each = each = (f, xs) --> 
  for x in xs then f x
  xs

exports.map = map = (f, xs) --> 
  result = []
  for x in xs then result.push f x
  result

exports.cons = cons = (x, xs) --> x & xs

exports.append = append = (xs, ys) --> xs +++ ys

exports.filter = filter = (f, xs) --> 
  result = []
  for x in xs when f x then result.push x
  result

exports.reject = reject = (f, xs) -->
  result = []
  for x in xs when not f x then result.push x
  result

exports.find = find = (f, xs) -->
  for x in xs when f x then return x
  void

exports.pluck = pluck = (prop, xs) -->
  result = []
  for x in xs when x[prop]? then result.push x[prop]
  result

exports.head = head = (xs) -> 
  return void if not xs.length
  xs.slice 0, 1

exports.tail = tail = (xs) -> 
  return void if not xs.length
  xs.slice 1

exports.last = last = (xs) ->
  return void if not xs.length
  xs.slice xs.length - 1

exports.initial = initial = (xs) -> 
  return void if not xs.length
  xs.slice 0, xs.length - 1

exports.empty = empty = (xs) -> not xs.length

exports.length = length = (xs) -> xs.length

exports.reverse = reverse = (xs) -> xs.slice!reverse!

exports.fold = fold = exports.foldl = foldl = (f, memo, xs) -->
  for x in xs then memo = f memo, x
  memo

exports.fold1 = fold1 = exports.foldl1 = foldl1 = (f, xs) --> fold f, xs.0, xs.slice 1

exports.foldr = foldr = (f, memo, xs) --> fold f, memo, xs.reverse!

exports.foldr1 = foldr1 = (f, xs) --> 
  xs.reverse!
  fold f, xs.0, xs.slice 1

exports.andList = andList = (xs) -> fold ((memo, x) -> memo and x), true, xs

exports.orList = orList = (xs) -> fold ((memo, x) -> memo or x), false, xs

exports.any = any = (f, xs) --> fold ((memo, x) -> memo or f x), false, xs

exports.all = all = (f, xs) --> fold ((memo, x) -> memo and f x), true, xs

exports.sum = sum = (xs) ->
  result = 0 
  for x in xs then result += x
  result

exports.product = product = (xs) ->
  result = 1
  for x in xs then result *= x
  result

exports.mean = mean = exports.average = average = (xs) ->
  sum = 0
  for x in xs then sum += x
  sum / xs.length

exports.concat = concat = (xss) -> fold append, [], xss

exports.concatMap = concatMap = (f, xs) --> concat map f, xs

exports.unique = unique = (xs) ->
  result = []
  for x in xs when x not in result
    result.push x
  result

exports.listToObject = listToObject = (xs) ->
  result = {}
  for x in xs
    result[x[0]] = x[1]
  result

exports.maximum = maximum = (xs) -> 
  return void if not xs.length
  Math.max.apply(this, xs)

exports.minimum = minimum = (xs) -> 
  return void if not xs.length
  Math.min.apply(this, xs)

exports.scan = scan = exports.scanl = scanl = (f, memo, xs) --> 
  result = [memo]
  last = memo
  for x in xs
    result.push (last = f last, x)
  result

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
  | n <= 0        => []
  | not xs.length => []
  | otherwise     => xs.slice 0, n

exports.drop = drop = (n, xs) -->
  | n <= 0        => xs
  | not xs.length => []
  | otherwise     => xs.slice n

exports.splitAt = splitAt = (n, xs) --> [(take n, xs), (drop n, xs)]

exports.takeWhile = takeWhile = (p, xs) -->
  return [] if not xs.length
  i = 0
  for x in xs
    break if not p x
    ++i
  take i, xs

exports.dropWhile = dropWhile = (p, xs) -->
  return [] if not xs.length
  i = 0
  for x in xs
    break if not p x
    ++i
  drop i, xs

exports.span = span = (p, xs) --> [(takeWhile p, xs), (dropWhile p, xs)]

exports.breakList = breakList = (p, xs) --> span (not) << p, xs

exports.elem = elem = (x, ys) --> x in ys

exports.notElem = notElem = (x, ys) --> x not in ys

exports.lookup = lookup = (key, xs) --> xs?[key]

exports.call = call = (key, xs) --> xs?[key]?!

exports.zip = zip = (...xss) -> 
  result = []
  for xs, i in xss
    for x, j in xs
      result.push [] if i is 0  
      result[j]?.push x
  result

exports.zipWith = zipWith = (f, ...xss) ->
  if not xss.0.length or not xss.1.length
    []
  else
    result = []
    for xs in zip.apply(this, xss) then result.push f.apply(this, xs) 
    result

# string

exports.lines = lines = (str) -> 
  return [] if not str.length
  str.split \\n

exports.unlines = unlines = (strs) -> strs.join \\n

exports.words = words = (str) -> 
  return [] if not str.length
  str.split ' '

exports.unwords = unwords = (strs) -> strs.join ' '
