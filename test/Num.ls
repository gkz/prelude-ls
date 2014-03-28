{
  max, min, negate, abs, signum, quot, rem, div, mod, recip,
  pi, tau, exp, sqrt, ln, pow, sin, tan, cos, acos, asin, atan, atan2,
  truncate, round, ceiling, floor, is-it-NaN, even, odd, gcd, lcm,
} = require '..'
{strict-equal: eq, deep-equal: deep-eq, ok} = require 'assert'

suite 'max' ->
  test 'numbers' ->
    eq 3, max 3 3
    eq 3, max 2 3
    eq 3, max 3 2

  test 'characters' ->
    eq \b, max \a \b

  test 'curried' ->
    f = max 2
    eq 3, f 3

suite 'min' ->
  test 'numbers' ->
    eq 0, min 9 0

  test 'characters' ->
    eq \a, min \a \b

  test 'curried' ->
    f = min 9
    eq 0, f 0

suite 'negate' ->
  test 'zero' ->
    eq 0, negate 0

  test 'negative number' ->
    eq -2, negate 2

  test 'positive number' ->
    eq 3, negate -3

suite 'abs' ->
  test 'zero' ->
    eq 0, abs 0

  test 'negative number' ->
    eq 4 abs -4

  test 'positive number' ->
    eq 4 abs  4

suite 'signum' ->
  test 'zero' ->
    eq 0  signum 0

  test 'negative number' ->
    eq -1 signum -5.3

  test 'positive number' ->
    eq 1  signum 8

suite 'quot' ->
  test 'simple' ->
    eq -6, quot -20 3

  test 'curried' ->
    f = quot -20
    eq -6, f 3

suite 'rem' ->
  test 'simple' ->
    eq -2, rem -20 3

  test 'curried' ->
    f = rem -20
    eq -2, f 3

suite 'div' ->
  test 'simple' ->
    eq -7, div -20 3

  test 'curried' ->
    f = div -20
    eq -7, f 3

suite 'mod' ->
  test 'simple' ->
    eq 1, mod -20 3

  test 'curried' ->
    f = mod -20
    eq 1, f 3

suite 'recip' ->
  test 'zero' ->
    eq Infinity, recip 0

  test 'larger than 1' ->
    eq 0.5, recip 2

  test 'between 0 and 1' ->
    eq 2, recip 0.5

suite 'pi' ->
  test 'constant' ->
    eq 3.141592653589793, pi

suite 'tau' ->
  test 'constant' ->
    eq 6.283185307179586, tau

suite 'exp' ->
  test 'simple' ->
    eq 2.718281828459045, exp 1

suite 'sqrt' ->
  test 'negative numbers' ->
    ok is-it-NaN sqrt -1

  test 'simple' ->
    eq 2 sqrt 4

suite 'ln' ->
  test 'simple' ->
    eq 0.6931471805599453, ln 2

suite 'pow' ->
  test 'simple' ->
    eq 4, pow 2 2
    eq 4, pow -2 2

  test 'with negative numbers' ->
    eq 0.25, pow 2 -2

  test 'between one and zero' ->
    eq 4, pow 16 0.5

  test 'curried' ->
    f = pow 2
    eq 4, f 2

suite 'sin' ->
  test 'zero' ->
    eq 0, sin 0

  test 'one' ->
    eq 0.8414709848078965, sin 1

suite 'tan' ->
  test 'zero' ->
    eq 0, tan 0

  test 'one' ->
    eq 1.5574077246549023, tan 1

suite 'cos' ->
  test 'zero' ->
    eq 1, cos 0

  test 'one' ->
    eq 0.5403023058681398, cos 1

suite 'acos' ->
  test 'number' ->
    eq 1.4706289056333368, acos 0.1

suite 'asin' ->
  test 'number' ->
    eq 1.5707963267948966, asin 1

suite 'atan' ->
  test 'number' ->
    eq 0.7853981633974483, atan 1

suite 'atan2' ->
  test 'number' ->
    eq 0.4636476090008061, atan2 1 2

  test 'curried' ->
    f = atan2 1
    eq 0.4636476090008061, f 2

suite 'truncate' ->
  test 'zero' ->
    eq 0, truncate 0

  test 'positive number' ->
    eq  1 truncate  1.5

  test 'negative number' ->
    eq -1 truncate -1.5

suite 'round' ->
  test 'up' ->
    eq 1 round 0.6
    eq 1 round 0.5

  test 'down' ->
    eq 0 round 0.4

suite 'ceiling' ->
  test 'zero' ->
    eq 0, ceiling 0

  test 'positive number' ->
    eq 1, ceiling 0.1

  test 'negative number' ->
    eq 0, ceiling -0.9

suite 'floor' ->
  test 'zero' ->
    eq 0, floor 0

  test 'positive number' ->
    eq 0, floor 0.9

  test 'negative number' ->
    eq -1, floor -0.1

suite 'is-it-NaN' ->
  test 'true' ->
    ok is-it-NaN Math.sqrt -1

  test 'false' ->
    ok not is-it-NaN '0'

suite 'even' ->
  test 'true' ->
    ok even 0
    ok even -2

  test 'false' ->
    ok not even 7

suite 'odd' ->
  test 'true' ->
    ok odd 3

  test 'false' ->
    ok not odd -4
    ok not odd 0

suite 'gcd' ->
  test 'some numbers' ->
    eq 6, gcd 12 18

  test 'curried' ->
    f = gcd 12
    eq 6, f 18

suite 'lcm' ->
  test 'some numbers' ->
    eq 36, lcm 12 18

  test 'curried' ->
    f = lcm 12
    eq 36, f 18
