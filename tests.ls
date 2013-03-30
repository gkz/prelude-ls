global <<< require \./prelude.js

# each
ok is-empty-list each ->, []
eq '1,2' "#{ each (.pop!), [[1 5] [2 6]] }"

test-target = 0
eq 'hello' each (-> ++test-target), 'hello'
eq 5 test-target
eq '' each (->), ''

count = 4
each (-> count += it), {a: 1, b: 2, c: 3}
eq 10 count

# map
ok is-empty-list map ->, []
ok arr-eq [2 3 4] map (+ 1), [1 2 3]

eq 'ABC' map (.to-upper-case!), 'abc'

obj = map (* 2), {a:1, b:2}
ok obj-eq {a:2, b:4} obj

ok arr-eq [1, 2, 3, 4] map {one: 1, two: 2, three: 3, four: 4}, <[ one two three four ]>

switches = map [\off \on], {power: 1, light: 0}
ok obj-eq {power: \on, light: \off} switches

# filter
ok is-empty-list filter id, []
ok arr-eq [2, 4] filter even, [1 to 5]

eq 'abcc' filter (in [\a to \c]), 'abcdefcf'
obj = filter (== 2), {a:1, b:2}
ok obj-eq {b: 2} obj

# compact
ok is-empty-list compact id, []
ok arr-eq [1 true 'ha'] compact [0 1 false true '' 'ha']

# reject
ok arr-eq [1 3 5] reject even, [1 to 5]

eq 'deff' reject (in [\a to \c]), 'abcdefcf'

obj = reject (==2), {a:1, b:2}
ok obj-eq {a: 1} obj

# partition
[passed, failed] = partition (>60), [49 58 76 43 88 77 90]
ok arr-eq [76 88 77 90] passed
ok arr-eq [49 58 43]    failed

[is-two, not-two] = partition (==2), {a:1, b:2, c:3}
ok obj-eq {b: 2} is-two
ok obj-eq {a: 1, c: 3} not-two

ok arr-eq ['abcc', 'deff'] partition (-> it in [\a to \c]), 'abcdefcf'

# find
eq 4 find even, [3 1 4 8 6]

eq 'b' find (== \b), 'abs'

eq 2, find (==2), {a:1, b:2}


list = [1 2 3 4 5]
string = 'abcde'

# head
eq 1 head list
ok not (head [])?

eq 'a' head string
ok not (head '')?

# tail
ok arr-eq [2 3 4 5] tail list
ok not (tail [])?

eq 'bcde' tail string
ok not (tail '')?

# last
eq 5 last list
ok not (last [])?

eq 'e' last string
ok not (last '')?

# initial
ok arr-eq [1 2 3 4] initial list
ok not (initial [])?

eq 'abcd' initial string
ok not (initial '')?

# empty
ok empty []
ok not empty [1]

ok empty {}
ok not empty {x: 1}

ok empty ''
ok not empty '1'

# values
ok arr-eq [1 2 3] values sadf: 1, asdf: 2, fdas: 3

# keys
ok arr-eq <[ sadf asdf fdas ]> keys sadf: 1, asdf: 2, fdas: 3
ok arr-eq <[ 0 1 2 ]> keys [1 2 3]

# len
eq 5 len list
eq 0 len []

eq 3 len {x: 1, y: 2, z: 3}
eq 0 len {}

eq 4 len 'abcd'
eq 0 len ''

# join
eq '1,2,3' join \, [1 2 3]

# reverse
ok arr-eq [5 4 3 2 1] reverse list
ok arr-eq [1 2 3 4 5] list # list is unmodified
ok is-empty-list reverse []

eq 'dcba' reverse 'abcd'
eq ''     reverse ''

# difference
ok arr-eq [1 3 4] difference [[1 2 3 4 5] [5 2 10] [9]]
ok is-empty-list difference [[] [] []]
ok arr-eq [1 2 3] difference [[1 2 3] []]

# intersection
ok arr-eq [1 2] intersection [[1 2 3] [101 2 1 10] [2 1] [-1 0 1 2]]
ok is-empty-list intersection [[] [] []]
ok is-empty-list intersection [[2 3] [9 8] [12 1] [99]]

# union
ok arr-eq [1 5 7 3] union [[1 5 7] [3 5] []]
ok is-empty-list union [[] []]
ok is-empty-list union []

# count-by
ok obj-eq {4: 1, 6: 2} count-by floor, [4.2, 6.1, 6.4]
ok obj-eq {3: 2, 5: 1} count-by (.length), <[ one two three ]>
ok is-empty-object count-by id, []

# group-by
grouped = group-by floor, [4.2, 6.1, 6.4]
ok 2 is len grouped
ok arr-eq grouped.4, [4.2]
ok arr-eq grouped.6, [6.1 6.4]

grouped = group-by (.length), <[ one two three ]>
ok 2 is len grouped
ok arr-eq grouped.3, <[ one two ]>
ok arr-eq grouped.5, <[ three ]>

ok is-empty-object group-by id, []

# fold
eq 12 fold (+), 0, [1 2 3 6]
eq 0 fold (+), 0, []

eq 'abc' fold (+), '', 'abc'
eq '' fold (+), '', ''

eq 12 fold (+), 0, {a: 1, b: 2, c: 3, d: 6}
eq 0 fold (+), 0, {}

eq 12 foldl (+), 0, [1 2 3 6]

# fold1
eq 12 fold1 (+), [1 2 3 6]
eq 12 foldl1 (+), [1 2 3 6]

# foldr
eq -1 foldr (-), 9, [1 2 3 4]

# foldr1
eq -1 foldr1 (-), [1 2 3 4 9]

# unfoldr
ok arr-eq [10,9,8,7,6,5,4,3,2,1] unfoldr (-> if it == 0 then null else [it, it - 1]), 10

# and-list
ok and-list [true, 2 + 2 == 4]
ok not and-list [true true false true]
ok and-list []

# or-list
ok or-list [false false false true false]
ok not or-list [false, 2 + 2 == 3]
ok not or-list []

# any
ok any even, [1 4 3]
ok not any even, [1 3 7 5]
ok not any even, []

ok any (== \M), 'mmmhMmm'
ok not any (== \Z), 'mmmhMmm'
ok not any (== \Z), ''

# all
ok all even, [2 4 6]
ok not all even, [2 5 6]
ok all even, []

ok all (== \M), 'MMMMMM'
ok not all (== \M), 'MMMmMM'
ok all (== \M), ''

# unique
ok arr-eq [1,2,3,4,5,6] unique [1 1 2 3 3 4 5 5 5 5 5 6 6 6 6]

ok arr-eq [2 3] unique a: 2, b: 3, c: 2

eq 'abcd' unique 'aaabbbcccdd'

# compare
eq -1 (compare (.length), [1 to 3], [0 to 5])
eq  1 (compare (.length), [1 to 9], [0 to 5])
eq  0 (compare (.length), [1 to 4], [4 to 7])

# sort
ok arr-eq [1,2,3,4,5,6] sort [3 1 5 2 4 6]
ok arr-eq [2,5,6,12,334,4999] sort [334 12 5 2 4999 6]
ok is-empty-list sort []

# sort-with
obj = one: 1, two: 2, three: 3
ok arr-eq ['one','two','three'] sort-with (compare (obj.)), <[ three one two ]>
ok is-empty-list sort-with ->, []

# sort-by
arr =
  [1 2 3]
  [4]
  [5 6 7 8]
  [9 10]
ok arr-eq [4,9,10,1,2,3,5,6,7,8] flatten sort-by (.length), arr
ok is-empty-list sort-by ->, []

# sum
eq 10 sum [1 2 3 4]
eq 0  sum []

eq 10 sum {a: 1, b: 2, c: 3, d: 4}
eq 0  sum {}

# product
eq 24 product [1 2 3 4]
eq 1  product []

eq 24 product {a: 1, b: 2, c: 3, d: 4}
eq 1  product {}

# mean
eq 4 mean [2 3 4 5 6]
eq 4 average [2 3 4 5 6]
ok is-it-NaN mean []

eq 4 mean {a: 2, b: 3, c: 4, d: 5, e: 6}

# concat
ok arr-eq [1,2,3,4,5,6] concat [[1 2] [3 4] [5 6]]
ok is-empty-list concat []

# concat-map
ok arr-eq [1,1,2,1,2,3] concat-map (-> [1 to it]), [1 2 3]
ok is-empty-list concat-map ->, []

# flatten
ok arr-eq [1,2,3,4,5] flatten [1, [[2], 3], [4, [[5]]]]

# maximum
eq 6 maximum [1 2 6 4 5]
ok not (maximum [])?

eq \f maximum [\a to \f]

# minimum
eq 2 minimum [4 3 2 6 9]

eq \a minimum [\a to \f]
ok not (minimum [])?

# scan
ok arr-eq [4,9,20,43] scan ((x, y) -> 2 * x + y), 4, [1 2 3]
eq 1 (res = scan (+), 0, []).length
eq '0' "#res"

# scan1
ok arr-eq [1,3,6,10] scan1 (+), [1 2 3 4]

# scanr
ok arr-eq [15,14,12,9,5] scanr (+), 5, [1 2 3 4]

# scanr1
ok arr-eq [10,9,7,4] scanr1 (+), [1 2 3 4]

# replicate
ok arr-eq [3,3,3,3] replicate 4 3
ok is-empty-list replicate 0 0

ok arr-eq <[ a a a a ]> replicate 4 \a
ok is-empty-list replicate 0 \a

# take
ok arr-eq [1,2,3] take 3 [1 2 3 4 5]
ok is-empty-list take 3 []
ok is-empty-list take -1 [1 to 5]

eq 'ab' take 2 string
eq ''   take 3 ''
eq ''   take 0 string

# drop
ok arr-eq [4,5] drop 3 [1 2 3 4 5]
ok is-empty-list drop 3 []
ok arr-eq [1,2,3,4,5] drop 0 [1 to 5]

eq 'cde'   drop 2 string
eq ''      drop 2 ''
eq 'abcde' drop 0 string

# split-at
eq '1,2,3|4,5' "#{ split-at 3, [1 2 3 4 5] .join \| }"
eq 2 (res = split-at 3 []).length
ok is-empty-list res.0
ok is-empty-list res.1

eq 'abc|de' "#{ split-at 3, 'abcde' .join \| }"
eq 2 (res = split-at 3 '').length
eq '' res.0
eq '' res.1

# take-while
ok arr-eq [1,3,5] takeWhile odd, [1 3 5 4 8 7 9]
ok is-empty-list takeWhile odd, []

eq 'mmmmm' takeWhile (is 'm'), 'mmmmmhmm'
eq '' takeWhile (is 'm'), ''

# drop-while
ok arr-eq [7,9,10] drop-while even, [2 4 6 7 9 10]
ok is-empty-list drop-while odd, []

eq 'hmm' drop-while (is \m), 'mmmmmhmm'
eq '' drop-while (is \m), ''

# span
eq '2,4,6|7,9,10' "#{ span even, [2 4 6 7 9 10] .join \|}"
eq 2 (res = span even, []).length
ok is-empty-list res.0
ok is-empty-list res.1

eq 'mmmmm|hmm' "#{ span (is \m), 'mmmmmhmm' .join \|}"
eq 2 (res = span (is \m), '').length
eq '' res.0
eq '' res.1

# break-list
eq '1,2|3,4,5' "#{ break-list (== 3), [1 2 3 4 5] .join \|}"
eq 2 (res = break-list even, []).length
ok is-empty-list res.0
ok is-empty-list res.1

eq 'mmmmm|hmm' "#{ break-list (== \h), 'mmmmmhmm' .join \|}"
eq 2 (res = break-list (== \h), '').length
eq ''  res.0
eq '' res.1

# list-to-obj
ok obj-eq {a: 'b', c: 'd', e: 1}, list-to-obj [['a' 'b'] ['c' 'd'] ['e' 1]]
ok is-empty-object list-to-obj []

# obj-to-func
eq 2 (obj-to-func {one: 1, two: 2})(\two)

# zip
eq '1,4|2,5' "#{ zip [1 2] [4 5] .join \| }"
ok is-empty-list zip [] []

# zip-with
ok arr-eq [4,4,4] zip-with (+), [1 2 3], [3 2 1]
ok is-empty-list zip-with id, [], []

# zip-all
eq '1,4,7|2,5,8|3,6,9' "#{ zip-all [1 2 3] [4 5 6] [7 8 9] .join \| }"
ok is-empty-list zip-all [] []

# zip-all-with
ok arr-eq [5,5,5] zip-all-with (-> &0 + &1 + &2), [1 2 3], [3 2 1], [1 1 1]
ok is-empty-list zip-all-with id, [], []

# curry
add = (x, y) -> x + y
add-curried = curry add
add-four = add-curried 4
eq 6 add-four 2

# id
eq 5 id 5

# flip
eq 10 (flip (-)) 5 15

# fix
eq 89 (fix (fib) -> (n) ->
  | n <= 1      => 1
  | otherwise   => fib(n-1) + fib(n-2))(10)

# fix (multi-arg variation)
eq 89 (fix (fib) -> (n, minus=0) ->
  | (n - minus) <= 1 => 1
  | otherwise        => fib(n, minus+1) + fib(n, minus+2))(10)

# split
ok arr-eq <[ 1 2 3 ]> split '|' '1|2|3'

# lines
ok arr-eq <[ one two three ]> lines 'one\ntwo\nthree'
ok is-empty-list lines ''

# unlines
eq 'one\ntwo\nthree' unlines [\one \two \three]
eq '' unlines []

# words
ok arr-eq <[ what is this ]> words 'what is this'
ok is-empty-list words ''
ok arr-eq <[ what is this ]> words 'what   is  this'

# unwords
eq 'what is this' unwords [\what \is \this]
eq '' unwords []

# chars
ok arr-eq <[ h e l l o ]> chars 'hello'
ok is-empty-list words ''

# unchars
eq 'there' unchars ['t', 'h', 'e', 'r', 'e']
eq '' unwords []

# max
eq 3 max 2 3
eq \b max \a \b

# min
eq 0 min 9 0
eq \a min \a \b

# negate
eq -2 negate 2
eq 3  negate -3
eq 0  negate 0

# abs
eq 4 abs -4
eq 4 abs  4

# signum
eq 1  signum 8
eq 0  signum 0
eq -1 signum -5.3

# quot
eq -6 quot -20 3

# rem
eq -2 rem -20 3

# div
eq -7 div -20 3

# mod
eq 1 mod -20 3

# recip
eq 0.5 recip 2

# pi
eq 3.141592653589793 pi

# tau
eq 6.283185307179586 tau

# exp
eq 2.718281828459045 exp 1

# sqrt
eq 2 sqrt 4

# ln
eq 0.6931471805599453 ln 2

# pow
eq 4 pow -2 2

# sin
eq 0.8414709848078965 sin 1
eq 0 sin 0

# tan
eq 1.5574077246549023 tan 1
eq 0 tan 0

# cos
eq 0.5403023058681398 cos 1
eq 1 cos 0

# acos
eq 1.4706289056333368 acos 0.1

# asin
eq 1.5707963267948966 asin 1

# atan
eq 0.7853981633974483 atan 1

# atan2
eq 0.4636476090008061 atan2 1 2

# sinh
# tanh
# cosh
# asinh
# atanh
# acosh

# truncate
eq -1 truncate -1.5
eq  1 truncate  1.5

# round
eq 1 round 0.6
eq 1 round 0.5
eq 0 round 0.4

# ceiling
eq 1 ceiling 0.1

# floor
eq 0 floor 0.9

# is-it-NaN
ok is-it-NaN Math.sqrt -1
ok not is-it-NaN '0'

# even
ok even -2
ok not even 7
ok even 0

# odd
ok odd 3
ok not odd -4
ok not odd 0

# gcd
eq 6 gcd 12 18

# lcm
eq 36 lcm 12 18


## util

ok is-empty-list []
ok not is-empty-list [1]

ok arr-eq [1 2] [1 2]
ok not arr-eq [2 1] [1 2]

ok is-empty-object {}
ok not is-empty-object {a: 1}

ok obj-eq {a: 1, b: 2} {b: 2, a: 1}
ok not obj-eq {a: 1} {a: 1, b: 2}

# functions for testing
function is-empty-list x
  typeof! x is 'Array' and not x.length

function arr-eq xs, ys
  return false unless xs.length is ys.length
  for x, i in xs
    return false unless x is ys[i]
  true

function obj-eq xs, ys
  for xk, xv of xs
    return false unless xk of ys and xv is ys[xk]
  for yk of ys
    return false unless yk of xs
  true

function is-empty-object xs
  for x of xs then return false
  true
