# This is very low level LiveScript, function calls -
# have been reduced at the expense of code reuse.
# This is to get the best performance possible out of 
# functions potentially called very often.

contradict = (x) -> not x

equals = (x, y) --> x == y

compose = (...funcs) -> 
  ->
    args = arguments
    for f in funcs
      args = [f.apply this, args]
    args.0

max = Math.max

min = Math.min

negate = (x) -> -x

abs = Math.abs

signum = (x) -> 
  | x < 0     => -1
  | x > 0     =>  1
  | otherwise =>  0

quot = (x, y) -> ~~(x / y)

rem = (x, y) -> x % y

div = (x, y) -> Math.floor x / y

mod = (x, y) -> x %% y

recip = (x) -> 1 / x

pi = Math.PI

exp = Math.exp

sqrt = Math.sqrt

log = Math.log

pow = Math.pow

sin = Math.sin

tan = Math.tan

cos = Math.cos

asin = Math.asin

atan = Math.atan

atan2 = Math.atan2

acos = Math.acos

# sinh
# tanh
# cosh
# asinh
# atanh
# acosh

truncate = (x) -> ~~x

round = Math.round

ceiling = Math.ceil

floor = Math.floor

isItNaN = (x) -> x isnt x

add = (x, y) --> x + y

minus = (x, y) --> x - y

subtract = (x, y) --> y - x

multiply = (x, y) --> x * y

divide = (x, y) --> x / y

divideBy = (x, y) --> y / x

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

# depends on gcd
lcm = (x, y) -->
  Math.abs Math.floor (x / (gcd x, y) * y)

id = (x) -> x

flip = (f, x, y) --> f y, x

error = (msg) -> throw msg

# collection
each = (f, xs) --> 
  for x in xs then f x
  xs

map = (f, xs) --> 
  result = []
  for x in xs then result.push f x
  result

cons = (x, xs) --> x & xs

append = (xs, ys) --> xs +++ ys

filter = (f, xs) --> 
  result = []
  for x in xs when f x then result.push x
  result

head = (xs) -> xs.slice 0, 1

tail = (xs) -> xs.slice 1

last = (xs) -> xs.slice xs.length - 1

initial = (xs) -> xs.slice 0, xs.length - 1

empty = (xs) -> not xs.length

length = (xs) -> xs.length

reverse = (xs) -> xs.slice!reverse!

fold = foldl = (f, memo, xs) -->
  for x in xs then memo = f memo, x
  memo

fold1 = foldl1 = (f, xs) --> fold f, xs.0, xs.slice 1

foldr = (f, memo, xs) --> fold f, memo, xs.reverse!

foldr1 = (f, xs) --> 
  xs.reverse!
  fold f, xs.0, xs.slice 1

andTest = (xs) -> fold ((memo, x) -> memo and x), true, xs

orTest = (xs) -> fold ((memo, x) -> memo or x), false, xs

any = (f, xs) --> fold ((memo, x) -> memo or f x), false, xs

all = (f, xs) --> fold ((memo, x) -> memo and f x), true, xs

sum = (xs) ->
  result = 0 
  for x in xs then result += x
  result

product = (xs) ->
  result = 1
  for x in xs then result *= x
  result

concat = (xss) -> fold append, [], xss

concatMap = (f, xs) --> concat map f, xs

maximum = (xs) -> Math.max.apply(this, xs)

minimum = (xs) -> Math.min.apply(this, xs)

scan = scanl = (f, memo, xs) --> 
  result = [memo]
  last = memo
  for x in xs
    result.push (last = f last, x)
  result


scan1 = scanl1 = (f, xs) --> scan f, xs.0, xs.slice 1

scanr = (f, memo, xs) --> 
  xs.reverse!
  scan f, memo, xs .reverse!

scanr1 = (f, xs) -->
  xs.reverse!
  scan f, xs.0, xs.slice 1 .reverse!

replicate = (n, x) --> 
  result = []
  i = 0
  while i < n, ++i then result.push x
  result

take = (n, xs) -->
  | n <= 0        => xs
  | not xs.length => []
  | otherwise     => xs.slice 0, n

drop = (n, xs) -->
  | n <= 0        => xs
  | not xs.length => []
  | otherwise     => xs.slice n

splitAt = (n, xs) --> [(take n, xs), (drop n, xs)]

takeWhile = (p, xs) -->
  return [] if not xs.length
  i = 0
  for x in xs
    break if not p x
    ++i
  take i, xs

dropWhile = (p, xs) -->
  return [] if not xs.length
  i = 0
  for x in xs
    break if not p x
    ++i
  drop i, xs

span = (p, xs) --> [(takeWhile p, xs), (dropWhile p, xs)]

breakList = (p, xs) --> span (contradict << p), xs

elem = (x, ys) --> x in ys

notElem = (x, ys) --> x not in ys

lookup = (key, xs) --> xs?[key]

zip = (...xss) -> 
  result = []
  for xs, i in xss
    for x, j in xs
      result.push [] if i is 0  
      result[j]?.push x
  result

zipWith = (f, ...xss) ->
  if not xss.0.length or not xss.1.length
    []
  else
    result = []
    for xs in zip.apply(this, xss) then result.push f.apply(this, xs) 
    result

lines = (str) -> str.split \\n

unlines = (str) -> str.join \\n

words = (str) -> str.split ' '

unwords = (str) -> str.join ' '
