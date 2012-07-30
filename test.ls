# each
ok isEmptyList each ->, []
eq '1,2' "#{ each (.pop!), [[1 5] [2 6]] }"

testTarget = 0
eq 'hello' each (-> ++testTarget), 'hello'
eq 5 testTarget
eq '' each (->), ''

count = 4
each (-> count += it), {a: 1, b: 2, c: 3}
eq 10 count

# map
ok isEmptyList map ->, []
eq '2,3,4' "#{ map (+ 1), [1 2 3] }"

eq 'ABC' map (-> it.toUpperCase!), 'abc'

obj = map (-> it * 2), {a:1, b:2}
eq 2 obj.a
eq 4 obj.b

eq '1,2,3,4' "#{ map {one: 1, two: 2, three: 3, four: 4}, <[ one two three four ]> }"

switches = map [\off \on], {power: 1, light: 0}
eq \on  switches.power 
eq \off switches.light

# filter 
ok isEmptyList filter id, []
eq '2,4' "#{ filter even, [1 to 5] }"

eq 'abcc' filter (-> it in [\a to \c]), 'abcdefcf'

obj = filter (==2), {a:1, b:2}
eq 2 obj.b
ok obj.a!?

# reject
eq '1,3,5' "#{ reject even, [1 to 5] }"

eq 'deff' reject (-> it in [\a to \c]), 'abcdefcf'

obj = reject (==2), {a:1, b:2}
eq 1 obj.a
ok obj.b!?

# partition
[passed, failed] = partition (>60), [49 58 76 43 88 77 90]
eq '76,88,77,90' "#passed"
eq '49,58,43'    "#failed"

[isTwo, notTwo] = partition (==2), {a:1, b:2, c:3}
eq 2 isTwo.b 
eq 1 notTwo.a
eq 3 notTwo.c

eq 'abcc,deff' "#{partition (-> it in [\a to \c]), 'abcdefcf'}"

# find
eq 4 find even, [3 1 4 8 6]

eq 'b' find (== \b), 'abs'

eq 2, find (==2), {a:1, b:2}


list = [1 2 3 4 5]
string = 'abcde'

# head
eq 1 head list
ok (head [])!?

eq 'a' head string
ok (head '')!?

# tail
eq '2,3,4,5' "#{ tail list }"
ok (tail [])!?

eq 'bcde' tail string
ok (tail '')!?

# last
eq 5 last list
ok (last [])!?

eq 'e' last string
ok (last '')!?

# initial
eq '1,2,3,4' "#{ initial list }"
ok (initial [])!?

eq 'abcd' initial string
ok (initial '')!?

# empty
ok empty []
ok not empty [1]

ok empty {}
ok not empty {x: 1}

ok empty ''
ok not empty '1'

# values
eq '1,2,3' "#{ values sadf: 1, asdf: 2, fdas: 3 }"

# keys
eq 'sadf,asdf,fdas' "#{ keys sadf: 1, asdf: 2, fdas: 3 }"
eq '0,1,2' "#{ keys [1 2 3] }"

# length
eq 5 length list
eq 0 length []

eq 3 length {x: 1, y: 2, z: 3}
eq 0 length {}

eq 4 length 'abcd'
eq 0 length ''

# cons 
eq '1,2,3' "#{ cons 1 [2 3] }"
eq '4,5' "#{ cons 4 5 }"

eq 'abc' cons \a 'bc'

# append
eq '1,2,3,4' "#{ append [1 2] [3 4] }"
eq '1,2,3' "#{ append [1 2] 3 }"

eq 'abcdef' append 'abc' 'def'

# join
eq '1,2,3' join \, [1 2 3]

# reverse
eq '5,4,3,2,1' "#{ reverse list }"
eq '1,2,3,4,5' "#{ list }" # list is unmodified
ok isEmptyList reverse []

eq 'dcba' reverse 'abcd'
eq ''     reverse ''

# fold
eq 12 fold (+), 0, [1 2 3 6]
eq 0 fold (+), 0, []

eq 'abc' fold (+), '', 'abc'
eq '' fold (+), '', ''

eq 12 fold (+), 0, {a: 1, b: 2, c: 3, d: 6}
eq 0 fold (+), 0, {}

# fold1
eq 12 fold1 (+), [1 2 3 6]

# foldr
eq -1 foldr (-), 9, [1 2 3 4]

# foldr1
eq -1 foldr1 (-), [1 2 3 4 9]

# unfoldr
eq '10,9,8,7,6,5,4,3,2,1' "#{ unfoldr (-> if it == 0 then null else [it, it - 1]), 10 }"

# andTest
ok andList [true, 2 + 2 == 4]
ok not andList [true true false true]
ok andList []

# orTest
ok orList [false false false true false]
ok not orList [false, 2 + 2 == 3]
ok not orList []

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
eq '1,2,3,4,5,6' "#{ unique [1 1 2 3 3 4 5 5 5 5 5 6 6 6 6] }"

eq '2,3' "#{  unique {a: 2, b: 3, c: 2} }"

eq 'abcd' unique 'aaabbbcccdd'

# sort
eq '1,2,3,4,5,6' "#{ sort [3 1 5 2 4 6] }"
eq '2,5,6,12,334,4999' "#{ sort [334 12 5 2 4999 6] }"
ok isEmptyList sort []

# sortBy
obj = one: 1, two: 2, three: 3
eq 'one,two,three' "#{ sortBy (compare (obj.)), <[ three one two ]> }"
ok isEmptyList sortBy ->, []

# compare
eq -1 (compare (.length), [1 to 3], [0 to 5])
eq  1 (compare (.length), [1 to 9], [0 to 5])
eq  0 (compare (.length), [1 to 4], [4 to 7])

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
ok isItNaN mean []

eq 4 mean {a: 2, b: 3, c: 4, d: 5, e: 6}

# concat
eq '1,2,3,4,5,6' "#{ concat [[1 2] [3 4] [5 6]] }"
ok isEmptyList concat []

eq 'aabbccdd' concat ['aa' 'bb' 'cc' 'dd']

# concatMap
eq '1,1,2,1,2,3' "#{ concatMap (-> [1 to it]), [1 2 3] }"
ok isEmptyList concatMap ->, []

eq 'AABBCCDD' concatMap (-> it.toUpperCase!), ['aa' 'bb' 'cc' 'dd']

# maximum
eq 6 maximum [1 2 6 4 5]
ok (maximum [])!?

eq \f maximum [\a to \f]

# minimum
eq 2 minimum [4 3 2 6 9]

eq \a minimum [\a to \f]
ok (minimum [])!?

# scan
eq '4,9,20,43' "#{ scan ((x, y) -> 2 * x + y), 4, [1 2 3] }"
eq 1 (res = scan (+), 0, []).length
eq '0' "#res"

# scan1
eq '1,3,6,10' "#{ scan1 (+), [1 2 3 4] }"

# scanr
eq '15,14,12,9,5' "#{ scanr (+), 5, [1 2 3 4] }"

# scanr1
eq '10,9,7,4' "#{ scanr1 (+), [1 2 3 4] }"

# replicate
eq '3,3,3,3' "#{ replicate 4 3 }"
ok isEmptyList replicate 0 0

eq 'a,a,a,a' "#{ replicate 4 \a }"
ok isEmptyList replicate 0 \a

# take
eq '1,2,3' "#{ take 3 [1 2 3 4 5] }"
ok isEmptyList take 3 []
ok isEmptyList take -1 [1 to 5]

eq 'ab' take 2 string
eq ''   take 3 ''
eq ''   take 0 string

# drop
eq '4,5' "#{ drop 3 [1 2 3 4 5] }"
ok isEmptyList drop 3 []
ok '1,2,3,4,5' "#{ drop 0 [1 to 5] }"

eq 'cde' drop 2 string
eq ''    drop 2 ''
eq 'abcde' drop 0 string

# splitAt
eq '1,2,3|4,5' "#{ splitAt 3, [1 2 3 4 5] .join \| }"
eq 2 (res = splitAt 3 []).length
ok isEmptyList res.0
ok isEmptyList res.1

eq 'abc|de' "#{ splitAt 3, 'abcde' .join \| }"
eq 2 (res = splitAt 3 '').length
eq '' res.0
eq '' res.1

# takeWhile
eq '1,3,5' "#{ takeWhile odd, [1 3 5 4 8 7 9] }"
ok isEmptyList takeWhile odd, []

eq 'mmmmm' takeWhile (is 'm'), 'mmmmmhmm'
eq '' takeWhile (is 'm'), ''

# dropWhile
eq '7,9,10' "#{ dropWhile even, [2 4 6 7 9 10] }"
ok isEmptyList dropWhile odd, []

eq 'hmm' dropWhile (is \m), 'mmmmmhmm'
eq '' dropWhile (is \m), ''

# span
eq '2,4,6|7,9,10' "#{ span even, [2 4 6 7 9 10] .join \|}"
eq 2 (res = span even, []).length
ok isEmptyList res.0
ok isEmptyList res.1

eq 'mmmmm|hmm' "#{ span (is \m), 'mmmmmhmm' .join \|}"
eq 2 (res = span (is \m), '').length
eq '' res.0
eq '' res.1

# breakIt
eq '1,2|3,4,5' "#{ breakIt (== 3), [1 2 3 4 5] .join \|}"
eq 2 (res = breakIt even, []).length
ok isEmptyList res.0
ok isEmptyList res.1

eq 'mmmmm|hmm' "#{ breakIt (== \h), 'mmmmmhmm' .join \|}"
eq 2 (res = breakIt (== \h), '').length
eq ''  res.0
eq '' res.1

# listToObj
objEq {a: 'b', c: 'd', e: 1}, listToObj [['a' 'b'] ['c' 'd'] ['e' 1]]
ok isEmptyObject listToObj []

# objToFunc
eq 2 (objToFunc {one: 1, two: 2})(\two)

# zip
eq '1,4|2,5' "#{ zip [1 2] [4 5] .join \| }"
ok isEmptyList zip [] []

# zipWith
eq '4,4,4' "#{ zipWith (+), [1 2 3], [3 2 1] }"
ok isEmptyList zipWith id, [], []

# zipAll
eq '1,4,7|2,5,8|3,6,9' "#{ zipAll [1 2 3] [4 5 6] [7 8 9] .join \| }"
ok isEmptyList zipAll [] []

# zipAllWith
eq '5,5,5' "#{ zipAllWith (-> &0 + &1 + &2), [1 2 3], [3 2 1], [1 1 1] }"
ok isEmptyList zipAllWith id, [], []

# compose
addTwo = (x) -> x + 2
timesTwo = (x) -> x * 2
minusOne = (x) -> x - 1
composed = compose addTwo, timesTwo, minusOne
eq 9, composed 3

# curry
add = (x, y) -> x + y
addCurried = curry add
addFour = addCurried 4
eq 6 addFour 2

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

# lines
eq 'one|two|three' "#{ lines 'one\ntwo\nthree' .join \| }"
ok isEmptyList lines ''

# unlines
eq 'one\ntwo\nthree' unlines [\one \two \three]
eq '' unlines []

# words
eq 'what|is|this' "#{ words 'what is this' .join \| }"
ok isEmptyList words '' 
eq 'what|is|this' "#{ words 'what   is  this' .join \| }"

# unwords
eq 'what is this' unwords [\what \is \this]
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

# isItNaN
ok isItNaN Math.sqrt -1
ok not isItNaN '0'

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

# functions for testing
function isEmptyList(x)
  '[object Array]' is {}.toString.call x and not x.length

function objEq(xs, ys)
  for xk, xv of xs
    for yk, yv of ys
      return no if xk isnt yk or xv isnt yv
  yes

function isEmptyObject(xs)
  for x of xs then return no
  yes
