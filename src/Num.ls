max = (>?)

min = (<?)

negate = (x) -> -x

abs = Math.abs

signum = (x) ->
  if x < 0
    -1
  else if x > 0
    1
  else
    0

quot = (x, y) --> ~~(x / y)

rem = (%)

div = (x, y) --> Math.floor x / y

mod = (%%)

recip = (1 /)

pi = Math.PI

tau = pi * 2

exp = Math.exp

sqrt = Math.sqrt

ln = Math.log

pow = (^)

sin = Math.sin

tan = Math.tan

cos = Math.cos

asin = Math.asin

acos = Math.acos

atan = Math.atan

atan2 = (x, y) --> Math.atan2 x, y

truncate = (x) -> ~~x

round = Math.round

ceiling = Math.ceil

floor = Math.floor

is-it-NaN = (x) -> x isnt x

even = (x) -> x % 2 == 0

odd = (x) -> x % 2 != 0

gcd = (x, y) -->
  x = Math.abs x
  y = Math.abs y
  until y is 0
    z = x % y
    x = y
    y = z
  x

lcm = (x, y) -->
  Math.abs Math.floor (x / (gcd x, y) * y)

module.exports = {
  max, min, negate, abs, signum, quot, rem, div, mod, recip,
  pi, tau, exp, sqrt, ln, pow, sin, tan, cos, acos, asin, atan, atan2,
  truncate, round, ceiling, floor, is-it-NaN, even, odd, gcd, lcm,
}
