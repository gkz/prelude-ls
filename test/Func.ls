{apply, curry, flip, fix, over} = require '..' .Func
{strict-equal: eq, deep-equal: deep-eq, ok} = require 'assert'

suite 'apply' ->
  test 'empty list' ->
    f = -> 1
    eq 1, apply f, []

  test 'a couple of args' ->
    eq 5, apply (+), [2 3]

  test 'curried' ->
    f = apply (+)
    eq 5, f [2 3]

suite 'curry' ->
  test 'simple function' ->
    add = (x, y) -> x + y
    add-curried = curry add
    add-four = add-curried 4
    eq 6 add-four 2

suite 'flip' ->
  test 'minus op' ->
    eq 10, (flip (-)) 5 15

suite 'fix' ->
  test 'single arg' ->
    eq 89, (fix (fib) -> (n) ->
      | n <= 1      => 1
      | otherwise   => fib(n-1) + fib(n-2))(10)

  test 'multi-arg variation' ->
    eq 89, (fix (fib) -> (n, minus=0) ->
      | (n - minus) <= 1 => 1
      | otherwise        => fib(n, minus+1) + fib(n, minus+2))(10)

suite 'over' ->
  test 'basic' ->
    f = (==) `over` (-> it)
    ok f 2 2
    ok not f 2 3

  test 'with accessor function' ->
    same-length = (==) `over` (.length)
    ok same-length [1 2 3] [4 5 6]
    ok not same-length [1 2] [4 5 6]
