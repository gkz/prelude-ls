# compose
addTwo = (x) -> x + 2
timesTwo = (x) -> x * 2
minusOne = (x) -> x - 1
composed = compose addTwo, timesTwo, minusOne
eq 9, composed 3

# max
eq 3 max 2 3

# min
eq 0 min 9 0

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

# exp
eq 2.718281828459045 exp 1

# sqrt
eq 2 sqrt 4

# log
eq 0.6931471805599453 log 2

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

# asin
eq 1.5707963267948966 asin 1

# atan
eq 0.7853981633974483 atan 1

# atan2
eq 0.4636476090008061 atan2 1 2

# acos
eq 1.4706289056333368 acos 0.1

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

# id 
eq 5 id 5

# each
ok isEmptyList each ->, [] 
eq '1,2' "#{ each (-> it.pop!), [[1 5] [2 6]] }"

# map
ok isEmptyList map ->, []
eq '2,3,4' "#{ map (+ 1), [1 2 3] }"

# cons 
eq '1,2,3' "#{ cons 1 [2 3] }"

# append
eq '1,2,3,4' "#{ append [1 2] [3 4] }"

# filter 
ok isEmptyList filter id, []
eq '2,4' "#{ filter even, [1 to 5] }"

# reject
eq '1,3,5' "#{ reject even, [1 to 5] }"

# find
eq 4 find even, [3 1 4 8 6]

# pluck
eq 'one,two' "#{ pluck \num [num: \one; num: \two] }"

list = [1 2 3 4 5]
# head
eq '1' "#{ head list }"
ok (head [])!?

# tail
eq '2,3,4,5' "#{ tail list }"
ok (tail [])!?

# last
eq '5' "#{ last list }"
ok (last [])!?

# initial
eq '1,2,3,4' "#{ initial list }"
ok (initial [])!?

# empty
ok empty []
ok not empty [1]

# length
eq 5 length list
eq 0 length []

# reverse
eq '5,4,3,2,1' "#{ reverse list }"
eq '1,2,3,4,5' "#{ list }" # list is unmodified
ok isEmptyList reverse []

# fold
eq 12 fold (+), 0, [1 2 3 6]
eq 0 fold (+), 0, []

# fold1
eq 12 fold1 (+), [1 2 3 6]

# foldr
eq -1 foldr (-), 9, [1 2 3 4]

# foldr1
eq -1 foldr1 (-), [1 2 3 4 9]

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

# all
ok all even, [2 4 6]
ok not all even, [2 5 6]
ok all even, []

# unique
eq '1,2,3,4,5,6' "#{ unique [1 1 2 3 3 4 5 5 5 5 5 6 6 6 6] }"

# sum
eq 10 sum [1 2 3 4]
eq 0 sum []

# product
eq 24 product [1 2 3 4]
eq 1 product []

# mean
eq 4 mean [2 3 4 5 6]
ok isItNaN mean []

# concat
eq '1,2,3,4,5,6' "#{ concat [[1 2] [3 4] [5 6]] }"
ok isEmptyList concat []

# concatMap
eq '1,1,2,1,2,3' "#{ concatMap (-> [1 to it]), [1 2 3] }"
ok isEmptyList concatMap ->, []

# maximum
eq 6 maximum [1 2 6 4 5]
ok (maximum [])!?

# minimum
eq 2 minimum [4 3 2 6 9]
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

# take
eq '1,2,3' "#{ take 3 [1 2 3 4 5] }"
ok isEmptyList take 3 []
ok isEmptyList take -1 [1 to 5]

# drop
eq '4,5' "#{ drop 3 [1 2 3 4 5] }"
ok isEmptyList drop 3 []
ok '1,2,3,4,5' "#{ drop 0 [1 to 5] }"

# splitAt
eq '1,2,3|4,5' "#{ splitAt 3, [1 2 3 4 5] .join \| }"
eq 2 (res = splitAt 3 []).length
ok isEmptyList res.0
ok isEmptyList res.1

# takeWhile
eq '1,3,5' "#{ takeWhile odd, [1 3 5 4 8 7 9] }"
ok isEmptyList takeWhile odd, []

# dropWhile
eq '7,9,10' "#{ dropWhile even, [2 4 6 7 9 10] }"
ok isEmptyList dropWhile odd, []

# span
eq '2,4,6|7,9,10' "#{ span even, [2 4 6 7 9 10] .join \|}"
eq 2 (res = span even, []).length
ok isEmptyList res.0
ok isEmptyList res.1

# breakList
eq '1,2|3,4,5' "#{ breakList (== 3), [1 2 3 4 5] .join \|}"
eq 2 (res = span even, []).length
ok isEmptyList res.0
ok isEmptyList res.1

# elem
ok elem 2 [1 to 5]
ok not elem 6 [1 to 5]
ok not elem 3 []

# notElem
ok notElem 0 [1 to 5]
ok not notElem 3 [1 to 5]
ok notElem 3 []

# lookup
eq 2 lookup \two, two: 2
eq 4 lookup 2, [2, 3, 4]
ok (lookup \two, {})!?

# call
eq 4 call \four, four: -> 4
ok (call \four, {})!?

# listToObj
objEq {a: 'b', c: 'd', e: 1}, listToObj [['a' 'b'] ['c' 'd'] ['e' 1]]
ok isEmptyObject listToObj []

# objToFunc
eq 2 (objToFunc {one: 1, two: 2})(\two)

# zip
eq '1,4,7|2,5,8|3,6,9' "#{ zip [1 2 3] [4 5 6] [7 8 9] .join \| }"
ok isEmptyList zip [] []

# zipWith
eq '4,4,4' "#{ zipWith (+), [1 2 3], [3 2 1] }"
ok isEmptyList zipWith id, [], []

# lines
eq 'one|two|three' "#{ lines 'one\ntwo\nthree' .join \| }"
ok isEmptyList lines ''

# unlines
eq 'one\ntwo\nthree' unlines [\one \two \three]
eq '' unlines []

# words
eq 'what|is|this' "#{ words 'what is this' .join \| }"
ok isEmptyList words '' 

# unwords
eq 'what is this' unwords [\what \is \this]
eq '' unwords []


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
