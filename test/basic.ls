# contradict
ok contradict false

# compose
addTwo = (x) -> x + 2
timesTwo = (x) -> x * 2
minusOne = (x) -> x - 1
composed = compose addTwo, timesTwo, minusOne
eq 9, composed 3

# max
eq 3 max 2 3 -4

# min
eq 0 min 9 0 1 5

# negate
eq -2 negate 2
eq 3  negate -3

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

# tan
eq 1.5574077246549023 tan 1

# cos
eq 0.5403023058681398 cos 1

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

# isNaN
ok isItNaN Math.sqrt -1
ok not isItNaN '0'

# add 
eq 5 add 2 3

# minus
eq -2 minus 3 5

# subtract
eq 2 subtract 3 5

# divide
eq 2 divide 8 4

# divideBy
eq 0.5 divideBy 8 4

# even
ok even -2
ok not even 7

# odd
ok odd 3
ok not odd -4

# gcd
eq 6 gcd 12 18

# lcm
eq 36 lcm 12 18

# id 
eq 5 id 5

# each
eq '1,2' "#{ each (-> it.pop!), [[1 5] [2 6]] }"

# map
eq '2,3,4' "#{ map (add 1), [1 2 3] }"

# cons 
eq '1,2,3' "#{ cons 1 [2 3] }"

# append
eq '1,2,3,4' "#{ append [1 2] [3 4] }"

# filter 
eq '2,4' "#{ filter even, [1 to 5] }"


list = [1 2 3 4 5]
# head
eq '1' "#{ head list }"

# tail
eq '2,3,4,5' "#{ tail list }"

# last
eq '5' "#{ last list }"

# initial
eq '1,2,3,4' "#{ initial list }"

# empty
ok empty []
ok not empty [1]

# length
eq 5 length list

# reverse
eq '5,4,3,2,1' "#{ reverse list }"
eq '1,2,3,4,5' "#{ list }" # list is unmodified

# fold
eq 12 fold add, 0, [1 2 3 6]

# fold1
eq 12 fold1 add, [1 2 3 6]

# foldr
eq 7 foldr subtract, 0, [1 2 3 4 9]

# foldr1
eq 7 foldr1 subtract, [1 2 3 4 9]

# andTest
ok andTest [true, 2 + 2 == 4]
ok not andTest [true true false true]

# orTest
ok orTest [false false false true false]
ok not orTest [false, 2 + 2 == 3]

# any
ok any even, [1 4 3]
ok not any even, [1 3 7 5]

# all
ok all even, [2 4 6]
ok not all even, [2 5 6]

# sum
eq 10 sum [1 2 3 4]

# product
eq 24 product [1 2 3 4]

# concat
eq '1,2,3,4,5,6' "#{ concat [[1 2] [3 4] [5 6]] }"

# concatMap
eq '1,1,2,1,2,3' "#{ concatMap (-> [1 to it]), [1 2 3] }"

# maximum
eq 6 maximum [1 2 6 4 5]

# minimum
eq 2 minimum [4 3 2 6 9]

# scan
eq '4,9,20,43' "#{ scan ((x, y) -> 2 * x + y), 4, [1 2 3] }"

# scan1
eq '1,3,6,10' "#{ scan1 add, [1 2 3 4] }"

# scanr
eq '15,14,12,9,5' "#{ scanr add, 5, [1 2 3 4] }"

# scanr1
eq '10,9,7,4' "#{ scanr1 add, [1 2 3 4] }"

# replicate
eq '3,3,3,3' "#{ replicate 4 3 }"

# take
eq '1,2,3' "#{ take 3 [1 2 3 4 5] }"

# drop
eq '4,5' "#{ drop 3 [1 2 3 4 5] }"

# splitAt
eq '1,2,3|4,5' "#{ splitAt 3, [1 2 3 4 5] .join \| }"

# takeWhile
eq '1,3,5' "#{ takeWhile odd, [1 3 5 4 8 7 9] }"

# dropWhile
eq '7,9,10' "#{ dropWhile even, [2 4 6 7 9 10] }"

# span
eq '2,4,6|7,9,10' "#{ span even, [2 4 6 7 9 10] .join \|}"

# breakList
eq '1,2|3,4,5' "#{ breakList (equals 3), [1 2 3 4 5] .join \|}"

# elem
ok elem 2 [1 to 5]
ok not elem 6 [1 to 5]

# notElem
ok notElem 0 [1 to 5]
ok not notElem 3 [1 to 5]

# lookup
eq 2 lookup \two, two: 2

# zip
eq '1,4,7|2,5,8|3,6,9' "#{ zip [1 2 3] [4 5 6] [7 8 9] .join \| }"

# zipWith
eq '4,4,4' "#{ zipWith add, [1 2 3], [3 2 1] }"

# lines
eq 'one|two|three' "#{ lines 'one\ntwo\nthree' .join \| }"

# unlines
eq 'one\ntwo\nthree' unlines [\one \two \three]

# words
eq 'what|is|this' "#{ words 'what is this' .join \| }"

# unwords
eq 'what is this' unwords [\what \is \this]
