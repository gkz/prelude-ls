# prelude.ls
is the recommended base library when using [LiveScript](http://gkz.github.com/LiveScript/), but will work in any JavaScript environment. The library is somewhat based of off Haskell's Prelude - thus the name. 

Any functions which take more than one argument (and a limited amount of arguments) can be partially applied. For instance, `add 4` will return a function which adds 4 to its argument.

## Examples
Using LiveScript:

    [1 2 3] |> map (* 2) |> filter (< 5) |> fold1 (+)
    #=> 6

prelude.ls is preloaded on the [LiveScript website](http://gkz.github.com/LiveScript/), you can play around with its functions there if you please.

## Usage
In the browser use `prelude-min.js` - it attaches itself to `window` as `prelude`. I like to import all its functions to `window`.

You can install via npm `npm install prelude-ls`

## Functions
#### compose
    :: ...Funcs -> Func
    (...funcs) -> f1 >> f2 >> ... >> fn
    
#### max
    :: Num -> Num -> Num
    
#### min
    :: Num -> Num -> Num
    
#### negate
    :: Num -> Num
    (x) -> -x
    
#### abs
    :: Num -> Num

Absolute value of the number.

#### signum
    :: Num -> (-1 | 0 | 1)

Returns -1, 0, or 1 depending on the sign of the number.

#### quot
    :: Num -> Num -> Num
    (x, y) --> ~~(x, y)
    
#### rem
    :: Num -> Num -> Num
    (x, y) --> x % y
    
#### div
    :: Num -> Num -> Num
    (x, y) --> floor(x / y)
    
#### mod
    :: Num -> Num -> Num
    (x, y) --> x % y
    
#### recip
    :: Num -> Num
    (x) -> 1 / x
    
#### pi
    :: Num
    3.1415...
    
#### exp
    :: Num -> Num
    
#### sqrt
    :: Num -> Num
    
#### log
    :: Num -> Num
    
#### pow
    :: Num -> Num -> Num
    (x, y) --> x ^ y
    
#### sin
    :: Num -> Num
    
#### tan
    :: Num -> Num
    
#### cos
    :: Num -> Num
    
#### asin
    :: Num -> Num
    
#### atan
    :: Num -> Num
    
#### atan2
    :: Num -> Num -> Num
    
#### acos
    :: Num -> Num
    
#### truncate
    :: Num -> Num
    (x) -> ~~x
    
#### round
    :: Num -> Num
    
#### ceiling
    :: Num -> Num
    
#### floor
    :: Num -> Num
    
#### isItNaN
    :: x -> Bool
    
#### even
    :: Num -> Bool
    
#### odd
    :: Num -> Bool
    
#### gcd
    :: Num -> Num -> Num

Greatest common denominator.
    
#### lcm
    :: Num -> Num -> Num

Least common multiple.

#### id
    :: x -> x
    (x) -> x
    
#### flip
    :: Func -> x -> y -> z
    (f, x, y) -> f y, z
    
#### error
    :: Str -> ()
    (msg) -> throw msg
    
#### each
    :: Func -> [x] -> [y]
    
#### map
    :: Func -> [x] -> [y]
    
#### cons
    :: x -> [y] -> [z]
    
#### append
    :: [x] -> [y] -> [z]
    
#### filter
    :: Func -> [x] -> [y]
    
#### reject
    :: Func -> [x] -> [y]
    
#### find
    :: Func -> [x] -> y
    
#### pluck
    :: Func -> [x] -> [y]

#### head
    :: [x] -> x
    
#### tail
    :: [x] -> [x]
    
#### last
    :: [x] -> x
    
#### initial
    :: [x] -> [x]
    
#### empty
    :: [x] -> Bool
    
#### length
    :: [x] -> Num
    
#### reverse
    :: [x] -> [y]
    
#### fold (foldl)
    :: Func -> x- > [y] -> z
    
#### fold1 (foldl1)
    :: Func -> [y] -> z
    
#### foldr 
    :: Func -> x- > [y] -> z
    
#### foldr1
    :: Func -> [y] -> z

#### unique
    :: [x] -> [y]

#### andList
    :: [Bool] -> Bool
    
#### orList
    :: [Bool] -> Bool
    
#### any
    :: Func -> [x] -> Bool
    
#### all
    :: Func -> [x] -> Bool
    
#### sum
    :: [Num] -> Num
    
#### product
    :: [Num] -> Num
    
#### mean (average)
    :: [Num] -> Num
    
#### concat
    :: [[x]] -> [x]
    
#### concatMap
    :: Func -> [[x]] -> [y]

#### maximum
    :: [Num] -> Num
    
#### minimum
    :: [Num] -> Num
    
#### scan
    :: Func -> x -> [y] -> [z]
    
#### scan1
    :: Func -> [x] -> [y]
    
#### scanr
    :: Func -> x -> [y] -> [z]
    
#### scanr1
    :: Func -> [x] -> [y]
    
#### replicate
    :: Num -> x -> [x]
    
#### take
    :: Num -> [x] -> [x]
    
#### drop
    :: Num -> [x] -> [x]
    
#### splitAt
    :: Num -> [x] -> [[x],[x]]
    
#### takeWhile
    :: Func -> [x] -> [x]
    
#### dropWhile
    :: Func -> [x] -> [x]
    
#### span
    :: Func -> [x] -> [[x],[x]]
    
#### breakList
    :: Func -> [x] -> [[x],[x]]
    
#### elem
    :: x -> [y] -> Bool
    
#### notElem
    :: x -> [y] -> Bool
    
#### lookup
    :: x -> (Obj | [y]) -> z

### call
    :: x -> Obj -> z
    
#### zip
    :: ...[x] -> [[x]]
    
#### zipWith
    :: Func -> ...[x] -> [[y]]
    
#### lines
    :: String -> [String]
    
#### unlines
    :: [String] -> String
    
#### words
    :: String -> [String]
    
#### unwords
    :: [String] -> String
    
#### listToObject
    :: [[a, b], [x, y]] -> {a: b, x: y}
