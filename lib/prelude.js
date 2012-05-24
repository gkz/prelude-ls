var contradict, equals, compose, max, min, negate, abs, signum, quot, rem, div, mod, recip, pi, exp, sqrt, log, pow, sin, tan, cos, asin, atan, atan2, acos, truncate, round, ceiling, floor, isItNaN, add, minus, subtract, multiply, divide, divideBy, even, odd, gcd, lcm, id, flip, error, each, map, cons, append, filter, head, tail, last, initial, empty, length, reverse, foldl, fold, foldl1, fold1, foldr, foldr1, andTest, orTest, any, all, sum, product, concat, concatMap, maximum, minimum, scanl, scan, scanl1, scan1, scanr, scanr1, replicate, take, drop, splitAt, takeWhile, dropWhile, span, breakList, elem, notElem, lookup, zip, zipWith, lines, unlines, words, unwords, __slice = [].slice;
contradict = function(x){
  return !x;
};
equals = __curry(function(x, y){
  return x === y;
});
compose = function(){
  var funcs;
  funcs = __slice.call(arguments);
  return function(){
    var args, f, __i, __ref, __len;
    args = arguments;
    for (__i = 0, __len = (__ref = funcs).length; __i < __len; ++__i) {
      f = __ref[__i];
      args = [f.apply(this, args)];
    }
    return args[0];
  };
};
max = Math.max;
min = Math.min;
negate = function(x){
  return -x;
};
abs = Math.abs;
signum = function(x){
  switch (false) {
  case !(x < 0):
    return -1;
  case !(x > 0):
    return 1;
  default:
    return 0;
  }
};
quot = function(x, y){
  return ~~(x / y);
};
rem = function(x, y){
  return x % y;
};
div = function(x, y){
  return Math.floor(x / y);
};
mod = function(x, y){
  var __ref;
  return ((x) % (__ref = y) + __ref) % __ref;
};
recip = function(x){
  return 1 / x;
};
pi = Math.PI;
exp = Math.exp;
sqrt = Math.sqrt;
log = Math.log;
pow = Math.pow;
sin = Math.sin;
tan = Math.tan;
cos = Math.cos;
asin = Math.asin;
atan = Math.atan;
atan2 = Math.atan2;
acos = Math.acos;
truncate = function(x){
  return ~~x;
};
round = Math.round;
ceiling = Math.ceil;
floor = Math.floor;
isItNaN = function(x){
  return x !== x;
};
add = __curry(function(x, y){
  return x + y;
});
minus = __curry(function(x, y){
  return x - y;
});
subtract = __curry(function(x, y){
  return y - x;
});
multiply = __curry(function(x, y){
  return x * y;
});
divide = __curry(function(x, y){
  return x / y;
});
divideBy = __curry(function(x, y){
  return y / x;
});
even = function(x){
  return x % 2 === 0;
};
odd = function(x){
  return x % 2 !== 0;
};
gcd = __curry(function(x, y){
  var z;
  x = Math.abs(x);
  y = Math.abs(y);
  while (y !== 0) {
    z = x % y;
    x = y;
    y = z;
  }
  return x;
});
lcm = __curry(function(x, y){
  return Math.abs(Math.floor(x / gcd(x, y) * y));
});
id = function(x){
  return x;
};
flip = __curry(function(f, x, y){
  return f(y, x);
});
error = function(msg){
  throw msg;
};
each = __curry(function(f, xs){
  var x, __i, __len;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    f(x);
  }
  return xs;
});
map = __curry(function(f, xs){
  var result, x, __i, __len;
  result = [];
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    result.push(f(x));
  }
  return result;
});
cons = __curry(function(x, xs){
  return [(x)].concat(xs);
});
append = __curry(function(xs, ys){
  return (xs).concat(ys);
});
filter = __curry(function(f, xs){
  var result, x, __i, __len;
  result = [];
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    if (f(x)) {
      result.push(x);
    }
  }
  return result;
});
head = function(xs){
  return xs.slice(0, 1);
};
tail = function(xs){
  return xs.slice(1);
};
last = function(xs){
  return xs.slice(xs.length - 1);
};
initial = function(xs){
  return xs.slice(0, xs.length - 1);
};
empty = function(xs){
  return !xs.length;
};
length = function(xs){
  return xs.length;
};
reverse = function(xs){
  return xs.slice().reverse();
};
fold = foldl = __curry(function(f, memo, xs){
  var x, __i, __len;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    memo = f(memo, x);
  }
  return memo;
});
fold1 = foldl1 = __curry(function(f, xs){
  return fold(f, xs[0], xs.slice(1));
});
foldr = __curry(function(f, memo, xs){
  return fold(f, memo, xs.reverse());
});
foldr1 = __curry(function(f, xs){
  xs.reverse();
  return fold(f, xs[0], xs.slice(1));
});
andTest = function(xs){
  return fold(function(memo, x){
    return memo && x;
  }, true, xs);
};
orTest = function(xs){
  return fold(function(memo, x){
    return memo || x;
  }, false, xs);
};
any = __curry(function(f, xs){
  return fold(function(memo, x){
    return memo || f(x);
  }, false, xs);
});
all = __curry(function(f, xs){
  return fold(function(memo, x){
    return memo && f(x);
  }, true, xs);
});
sum = function(xs){
  var result, x, __i, __len;
  result = 0;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    result += x;
  }
  return result;
};
product = function(xs){
  var result, x, __i, __len;
  result = 1;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    result *= x;
  }
  return result;
};
concat = function(xss){
  return fold(append, [], xss);
};
concatMap = __curry(function(f, xs){
  return concat(map(f, xs));
});
maximum = function(xs){
  return Math.max.apply(this, xs);
};
minimum = function(xs){
  return Math.min.apply(this, xs);
};
scan = scanl = __curry(function(f, memo, xs){
  var result, last, x, __i, __len;
  result = [memo];
  last = memo;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    result.push(last = f(last, x));
  }
  return result;
});
scan1 = scanl1 = __curry(function(f, xs){
  return scan(f, xs[0], xs.slice(1));
});
scanr = __curry(function(f, memo, xs){
  xs.reverse();
  return scan(f, memo, xs).reverse();
});
scanr1 = __curry(function(f, xs){
  xs.reverse();
  return scan(f, xs[0], xs.slice(1)).reverse();
});
replicate = __curry(function(n, x){
  var result, i;
  result = [];
  i = 0;
  for (; i < n; ++i) {
    result.push(x);
  }
  return result;
});
take = __curry(function(n, xs){
  switch (false) {
  case !(n <= 0):
    return xs;
  case !!xs.length:
    return [];
  default:
    return xs.slice(0, n);
  }
});
drop = __curry(function(n, xs){
  switch (false) {
  case !(n <= 0):
    return xs;
  case !!xs.length:
    return [];
  default:
    return xs.slice(n);
  }
});
splitAt = __curry(function(n, xs){
  return [take(n, xs), drop(n, xs)];
});
takeWhile = __curry(function(p, xs){
  var i, x, __i, __len;
  if (!xs.length) {
    return [];
  }
  i = 0;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    if (!p(x)) {
      break;
    }
    ++i;
  }
  return take(i, xs);
});
dropWhile = __curry(function(p, xs){
  var i, x, __i, __len;
  if (!xs.length) {
    return [];
  }
  i = 0;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    if (!p(x)) {
      break;
    }
    ++i;
  }
  return drop(i, xs);
});
span = __curry(function(p, xs){
  return [takeWhile(p, xs), dropWhile(p, xs)];
});
breakList = __curry(function(p, xs){
  return span(__compose((contradict),(p)), xs);
});
elem = __curry(function(x, ys){
  return __in(x, ys);
});
notElem = __curry(function(x, ys){
  return !__in(x, ys);
});
lookup = __curry(function(key, xs){
  return xs != null ? xs[key] : void 8;
});
zip = function(){
  var xss, result, i, xs, j, x, __len, __len1, __ref;
  xss = __slice.call(arguments);
  result = [];
  for (i = 0, __len = xss.length; i < __len; ++i) {
    xs = xss[i];
    for (j = 0, __len1 = xs.length; j < __len1; ++j) {
      x = xs[j];
      if (i === 0) {
        result.push([]);
      }
      if ((__ref = result[j]) != null) {
        __ref.push(x);
      }
    }
  }
  return result;
};
zipWith = function(f){
  var xss, result, xs, __i, __ref, __len;
  xss = __slice.call(arguments, 1);
  if (!xss[0].length || !xss[1].length) {
    return [];
  } else {
    result = [];
    for (__i = 0, __len = (__ref = zip.apply(this, xss)).length; __i < __len; ++__i) {
      xs = __ref[__i];
      result.push(f.apply(this, xs));
    }
    return result;
  }
};
lines = function(str){
  return str.split('\n');
};
unlines = function(str){
  return str.join('\n');
};
words = function(str){
  return str.split(' ');
};
unwords = function(str){
  return str.join(' ');
};
function __curry(f, args){
  return f.length ? function(){
    var params = args ? args.concat() : [];
    return params.push.apply(params, arguments) < f.length ?
      __curry.call(this, f, params) : f.apply(this, params);
  } : f;
}
function __compose(f, g){
  return function(){
    return f(g.apply(this, arguments)); 
  }
}
function __in(x, arr){
  var i = 0, l = arr.length >>> 0;
  while (i < l) if (x === arr[i++]) return true;
  return false;
}