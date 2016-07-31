require! \sinon
{apply, curry, flip, fix, over, memoize, tap} = require '..' .Func
{strict-equal: eq, not-strict-equal: not-eq, deep-equal: deep-eq, ok} = require 'assert'

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

suite 'memoize' ->
  spy = f = null

  setup ->
    spy := sinon.spy -> &
    f := memoize spy

  test 'only 1 call when using the same arguments' ->
    [0 to 10].for-each -> f!
    ok spy.called-once

  test 'call again when using different arguments' ->
    f \mung
    f \mung
    f '1,2'
    f [1 2]
    ok spy.called-thrice

  test 'that the correct values are returned' ->
    eq f(\mung), f(\mung)
    eq f(\mung \face), f(\mung \face)
    not-eq f(\mung), f(\mung \face)

suite 'tap' ->
  test 'basic' ->
    foo-called = false
    obj = foo: (-> foo-called := true)

    f = tap (.foo!)

    eq f(obj), obj
    eq foo-called, true
