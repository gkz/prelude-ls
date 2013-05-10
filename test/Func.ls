{apply, curry, flip, fix} = require '..' .Func
require! assert
{equal: eq, deep-equal: deep-eq, ok} = assert

suite 'apply' ->
  test 'empty list' ->
    f = -> 1
    eq 1, apply f, []

  test 'a couple of args' ->
    eq 5, apply (+), [2 3]

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
