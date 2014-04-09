require! [
  './Func.js'
  './List.js'
  './Obj.js'
  './Str.js'
  './Num.js'
]

id = (x) -> x

is-type = (type, x) --> typeof! x is type

replicate = (n, x) -->
  [x for til n]


Str <<< List{
  empty, slice, take, drop, split-at, take-while, drop-while, span, break-str: break-list
}

prelude = {
  Func, List, Obj, Str, Num,
  id, is-type
  replicate,
}
prelude <<< List{
  each, map, filter, compact, reject, partition, find,
  head, first, tail, last, initial, empty,
  reverse, difference, intersection, union, count-by, group-by,
  fold, foldl, fold1, foldl1, foldr, foldr1, unfoldr, and-list, or-list,
  any, all, unique, unique-by, sort, sort-with, sort-by, sum, product, mean, average,
  concat, concat-map, flatten,
  maximum, minimum, maximum-by, minimum-by,
  scan, scanl, scan1, scanl1, scanr, scanr1,
  slice, take, drop, split-at, take-while, drop-while, span, break-list,
  zip, zip-with, zip-all, zip-all-with,
  at, elem-index, elem-indices, find-index, find-indices,
}
prelude <<< Func{
  apply, curry, flip, fix, over,
}
prelude <<< Str{
  split, join, lines, unlines, words, unwords, chars, unchars,
  repeat, capitalize, camelize, dasherize,
}
# not importing all of Obj's functions
prelude <<< Obj{
  values, keys,
  pairs-to-obj, obj-to-pairs, lists-to-obj, obj-to-lists,
}
prelude <<< Num{
  max, min, negate, abs, signum, quot, rem, div, mod, recip,
  pi, tau, exp, sqrt, ln, pow, sin, tan, cos, acos, asin, atan, atan2,
  truncate, round, ceiling, floor, is-it-NaN, even, odd, gcd, lcm,
}

prelude.VERSION = '1.1.1'

module.exports = prelude
