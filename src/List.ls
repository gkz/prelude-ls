each = (f, xs) -->
  for x in xs
    f x
  xs

map = (f, xs) -->
  [f x for x in xs]

compact = (xs) -->
  [x for x in xs when x]

filter = (f, xs) -->
  [x for x in xs when f x]

reject = (f, xs) -->
  [x for x in xs when not f x]

partition = (f, xs) -->
  passed = []
  failed = []
  for x in xs
    (if f x then passed else failed).push x
  [passed, failed]

find = (f, xs) -->
  for x in xs when f x
    return x
  void

head = first = (xs) ->
  xs.0

tail = (xs) ->
  return void unless xs.length
  xs.slice 1

last = (xs) ->
  xs[*-1]

initial = (xs) ->
  return void unless xs.length
  xs.slice 0, -1

empty = (xs) ->
  not xs.length

reverse = (xs) ->
  xs.concat!.reverse!

unique = (xs) ->
  result = []
  for x in xs when x not in result
    result.push x
  result

unique-by = (f, xs) -->
  seen = []
  for x in xs
    val = f x
    continue if val in seen
    seen.push val
    x

fold = foldl = (f, memo, xs) -->
  for x in xs
    memo = f memo, x
  memo

fold1 = foldl1 = (f, xs) -->
  fold f, xs.0, xs.slice 1

foldr = (f, memo, xs) -->
  for x in xs by -1
    memo = f x, memo
  memo

foldr1 = (f, xs) -->
  foldr f, xs[*-1], xs.slice 0, -1

unfoldr = (f, b) -->
  result = []
  x = b
  while (f x)?
    result.push that.0
    x = that.1
  result

concat = (xss) ->
  [].concat.apply [], xss

concat-map = (f, xs) -->
  [].concat.apply [], [f x for x in xs]

flatten = (xs) -->
  [].concat.apply [], [(if typeof! x is 'Array' then flatten x else x) for x in xs]

difference = (xs, ...yss) ->
  results = []
  :outer for x in xs
    for ys in yss
      continue outer if x in ys
    results.push x
  results

intersection = (xs, ...yss) ->
  results = []
  :outer for x in xs
    for ys in yss
      continue outer unless x in ys
    results.push x
  results

union = (...xss) ->
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
  for x in xs when f x
    return true
  false

all = (f, xs) -->
  for x in xs when not f x
    return false
  true

sort = (xs) ->
  xs.concat!.sort (x, y) ->
    if x > y
      1
    else if x < y
      -1
    else
      0

sort-with = (f, xs) -->
  xs.concat!.sort f

sort-by = (f, xs) -->
  xs.concat!.sort (x, y) ->
    if (f x) > (f y)
      1
    else if (f x) < (f y)
      -1
    else
      0

sum = (xs) ->
  result = 0
  for x in xs
    result += x
  result

product = (xs) ->
  result = 1
  for x in xs
    result *= x
  result

mean = average = (xs) ->
  sum = 0
  for x in xs
    sum += x
  sum / xs.length

maximum = (xs) ->
  max = xs.0
  for x in xs.slice 1 when x > max
    max = x
  max

minimum = (xs) ->
  min = xs.0
  for x in xs.slice 1 when x < min
    min = x
  min

maximum-by = (f, xs) -->
  max = xs.0
  for x in xs.slice 1 when (f x) > (f max)
    max = x
  max

minimum-by = (f, xs) -->
  min = xs.0
  for x in xs.slice 1 when (f x) < (f min)
    min = x
  min

scan = scanl = (f, memo, xs) -->
  last = memo
  [memo] ++ [last = f last, x for x in xs]

scan1 = scanl1 = (f, xs) -->
  return void unless xs.length
  scan f, xs.0, xs.slice 1

scanr = (f, memo, xs) -->
  xs = xs.concat!.reverse!
  (scan f, memo, xs).reverse!

scanr1 = (f, xs) -->
  return void unless xs.length
  xs = xs.concat!.reverse!
  (scan f, xs.0, xs.slice 1).reverse!

slice = (x, y, xs) -->
  xs.slice x, y

take = (n, xs) -->
  if n <= 0
    xs.slice 0, 0
  else
    xs.slice 0, n

drop = (n, xs) -->
  if n <= 0
    xs
  else
    xs.slice n

split-at = (n, xs) --> [(take n, xs), (drop n, xs)]

take-while = (p, xs) -->
  len = xs.length
  return xs unless len
  i = 0
  while i < len and p xs[i]
    i += 1
  xs.slice 0 i

drop-while = (p, xs) -->
  len = xs.length
  return xs unless len
  i = 0
  while i < len and p xs[i]
    i += 1
  xs.slice i

span = (p, xs) --> [(take-while p, xs), (drop-while p, xs)]

break-list = (p, xs) --> span (not) << p, xs

zip = (xs, ys) -->
  result = []
  len = ys.length
  for x, i in xs
    break if i is len
    result.push [x, ys[i]]
  result

zip-with = (f, xs, ys) -->
  result = []
  len = ys.length
  for x, i in xs
    break if i is len
    result.push f x, ys[i]
  result

zip-all = (...xss) ->
  min-length = 9e9
  for xs in xss
    min-length <?= xs.length
  [[xs[i] for xs in xss] for i til min-length]

zip-all-with = (f, ...xss) ->
  min-length = 9e9
  for xs in xss
    min-length <?= xs.length
  [f.apply(null, [xs[i] for xs in xss]) for i til min-length]

at = (n, xs) -->
  if n < 0 then xs[xs.length + n] else xs[n]

elem-index = (el, xs) -->
  for x, i in xs when x is el
    return i
  void

elem-indices = (el, xs) -->
  [i for x, i in xs when x is el]

find-index = (f, xs) -->
  for x, i in xs when f x
    return i
  void

find-indices = (f, xs) -->
  [i for x, i in xs when f x]

module.exports = {
  each, map, filter, compact, reject, partition, find,
  head, first, tail, last, initial, empty,
  reverse, difference, intersection, union, count-by, group-by,
  fold, fold1, foldl, foldl1, foldr, foldr1, unfoldr, and-list, or-list,
  any, all, unique, unique-by, sort, sort-with, sort-by, sum, product, mean, average,
  concat, concat-map, flatten,
  maximum, minimum, maximum-by, minimum-by,
  scan, scan1, scanl, scanl1, scanr, scanr1,
  slice, take, drop, split-at, take-while, drop-while, span, break-list,
  zip, zip-with, zip-all, zip-all-with,
  at, elem-index, elem-indices, find-index, find-indices,
}
