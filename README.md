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

For developers looking to contribute you must have [LiveScript](http://gkz.github.com/LiveScript/) - install via npm using `sudo npm install -g LiveScript`. Use the commands `slake test` to run tests (always write any tests for any additions). Run `slake build:all` to build everything and run tests.

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

#### tau
    :: Num
    6.2831...
    
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
    
Applies function to each item in collection, returns original (modified) list.
    
#### map
    :: Func -> [x] -> [y]

Applies function to each item in collection, returns the resulting list.
    
#### cons
    :: x -> [y] -> [z]

Adds item to beginning of list, returns new list.
    
#### append
    :: [x] -> [y] -> [z]

Mashes two lists together, creating a new list.
    
#### filter
    :: Func -> [x] -> [y]

Returns list of all items in the collection for which the function evaluates to true.
    
#### reject
    :: Func -> [x] -> [y]
    
The opposite of filter.
    
#### find
    :: Func -> [x] -> y

Returns the first item which is true for the function.
    
#### pluck
    :: x -> [y] -> [z]

Returns list of the properties plucked from each item in the collection.

#### head
    :: [x] -> x

The first item in the list.
    
#### tail
    :: [x] -> [x]

All the items other than the first item of the list.
    
#### last
    :: [x] -> x

The last item in the list.
    
#### initial
    :: [x] -> [x]

All the items other than the last item in the list.
    
#### empty
    :: [x] -> Bool
    
Is the list empty?

#### length
    :: ([x] | String) -> Num
    
The length of the list or string.

#### reverse
    :: [x] -> [y]
    
The list reversed.

#### fold (foldl)
    :: Func -> x- > [y] -> z

Combines a collection into a single value using the function supplied and the starting value (x in this case).
    
#### fold1 (foldl1)
    :: Func -> [y] -> z

As above but without a giving starting value, just uses the first value of the collection.
    
#### foldr 
    :: Func -> x- > [y] -> z

As fold, but from the right.
    
#### foldr1
    :: Func -> [y] -> z

As fold1, but from the right.

#### andList
    :: [Bool] -> Bool

Fold based on doing `and` on all the items.
    
#### orList
    :: [Bool] -> Bool

Fold based on doing `or` on all the items.
    
#### any
    :: Func -> [x] -> Bool

If any items in the collection pass the test.
    
#### all
    :: Func -> [x] -> Bool

If all the items in the collection pass the test.

#### unique
    :: [x] -> [y]
    
Removes any duplicate items in the collection.

#### sum
    :: [Num] -> Num

#### product
    :: [Num] -> Num
    
#### mean (average)
    :: [Num] -> Num
    
#### concat
    :: [[x]] -> [x]

Turns a list of lists into one list.
    
#### concatMap
    :: Func -> [[x]] -> [y]

As above expect applies the function while this happens.

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

Replicates x the number of times specified.

#### take
    :: Num -> [x] -> [x]

Returns the first n items of the list. 
    
#### drop
    :: Num -> [x] -> [x]

Returns the list after dropping the first n items from the list.
    
#### splitAt
    :: Num -> [x] -> [[x],[x]]

Equivalent to `[(take n, xs), (drop n, xs)]`
    
#### takeWhile
    :: Func -> [x] -> [x]

Take items from the list while the function is true.
    
#### dropWhile
    :: Func -> [x] -> [x]

Drop items from the list while the function is true.
    
#### span
    :: Func -> [x] -> [[x],[x]]

Equivalent to `[(takeWhile f, xs), (dropWhile f, xs)]`
    
#### breakList
    :: Func -> [x] -> [[x],[x]]

Same as span but negating the function.
    
#### elem
    :: x -> [y] -> Bool
    (x, y) -> x in y
    
#### notElem
    :: x -> [y] -> Bool
    (x, y) -> x not in y
    
#### lookup
    :: x -> y -> z
    (prop, y) -> y[prop]

### call
    :: x -> y -> z
    (prop, y) -> y[prop]()

#### listToObj
    :: [[a, b], [x, y]] -> {a: b, x: y}

#### objToFunc
    :: Obj -> (y -> z)
    (obj) -> 
      (key) -> obj[key]
    
#### zip
    :: ...[x] -> [[x]]

Turns `[1 2] [3 4]` into `[1 3] [2 4]`
    
#### zipWith
    :: Func -> ...[x] -> [[y]]

Same as zip but applies function as well.
    
#### lines
    :: String -> [String]
    
The string split by newlines.

#### unlines
    :: [String] -> String

Turns list of strings into a string joined by newlines.
    
#### words
    :: String -> [String]
    
The string split by spaces.

#### unwords
    :: [String] -> String

Turns list of strings into a string joined by spaces.
