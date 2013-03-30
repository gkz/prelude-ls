// prelude.ls 0.7.0-dev
// Copyright (c) 2013 George Zahariev
// Released under the MIT License
// raw.github.com/gkz/prelude-ls/master/LICNSE
var objToFunc, listToObj, each, map, filter, compact, reject, partition, find, head, first, tail, last, initial, empty, values, keys, len, join, reverse, unique, fold, foldl, fold1, foldl1, foldr, foldr1, unfoldr, unfold, concat, concatMap, flatten, difference, intersection, union, countBy, groupBy, andList, orList, any, all, compare, sort, sortWith, sortBy, sum, product, mean, average, maximum, minimum, scan, scanl, scan1, scanl1, scanr, scanr1, replicate, take, drop, splitAt, takeWhile, dropWhile, span, breakList, zip, zipWith, zipAll, zipAllWith, curry, id, flip, fix, split, lines, unlines, words, unwords, chars, unchars, max, min, negate, abs, signum, quot, rem, div, mod, recip, pi, tau, exp, sqrt, ln, pow, sin, tan, cos, asin, acos, atan, atan2, truncate, round, ceiling, floor, isItNaN, even, odd, gcd, lcm, prelude, exports, toString$ = {}.toString, join$ = [].join, slice$ = [].slice;
objToFunc = function(obj){
  return function(it){
    return obj[it];
  };
};
listToObj = function(xs){
  var i$, len$, x, results$ = {};
  for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
    x = xs[i$];
    results$[x[0]] = x[1];
  }
  return results$;
};
each = curry$(function(f, xs){
  var i$, x, len$;
  if (toString$.call(xs).slice(8, -1) === 'Object') {
    for (i$ in xs) {
      x = xs[i$];
      f(x);
    }
  } else {
    for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
      x = xs[i$];
      f(x);
    }
  }
  return xs;
});
map = curry$(function(f, xs){
  var type, key, x, result, res$, i$, len$, results$ = {};
  if (toString$.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  type = toString$.call(xs).slice(8, -1);
  if (type === 'Object') {
    for (key in xs) {
      x = xs[key];
      results$[key] = f(x);
    }
    return results$;
  } else {
    res$ = [];
    for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
      x = xs[i$];
      res$.push(f(x));
    }
    result = res$;
    if (type === 'String') {
      return result.join('');
    } else {
      return result;
    }
  }
});
filter = curry$(function(f, xs){
  var type, key, x, result, res$, i$, len$, results$ = {};
  if (toString$.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  type = toString$.call(xs).slice(8, -1);
  if (type === 'Object') {
    for (key in xs) {
      x = xs[key];
if (f(x)) {
        results$[key] = x;
      }
    }
    return results$;
  } else {
    res$ = [];
    for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
      x = xs[i$];
      if (f(x)) {
        res$.push(x);
      }
    }
    result = res$;
    if (type === 'String') {
      return result.join('');
    } else {
      return result;
    }
  }
});
compact = curry$(function(xs){
  var key, x, i$, len$, results$ = [];
  if (toString$.call(xs).slice(8, -1) === 'Object') {
    for (key in xs) {
      x = xs[key];
if (x) {
        results$[key] = x;
      }
    }
    return results$;
  } else {
    for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
      x = xs[i$];
      if (x) {
        results$.push(x);
      }
    }
    return results$;
  }
});
reject = curry$(function(f, xs){
  var type, key, x, result, res$, i$, len$, results$ = {};
  if (toString$.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  type = toString$.call(xs).slice(8, -1);
  if (type === 'Object') {
    for (key in xs) {
      x = xs[key];
if (!f(x)) {
        results$[key] = x;
      }
    }
    return results$;
  } else {
    res$ = [];
    for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
      x = xs[i$];
      if (!f(x)) {
        res$.push(x);
      }
    }
    result = res$;
    if (type === 'String') {
      return result.join('');
    } else {
      return result;
    }
  }
});
partition = curry$(function(f, xs){
  var type, passed, failed, key, x, i$, len$;
  if (toString$.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  type = toString$.call(xs).slice(8, -1);
  if (type === 'Object') {
    passed = {};
    failed = {};
    for (key in xs) {
      x = xs[key];
      (f(x) ? passed : failed)[key] = x;
    }
  } else {
    passed = [];
    failed = [];
    for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
      x = xs[i$];
      (f(x) ? passed : failed).push(x);
    }
    if (type === 'String') {
      passed = join$.call(passed, '');
      failed = join$.call(failed, '');
    }
  }
  return [passed, failed];
});
find = curry$(function(f, xs){
  var i$, x, len$;
  if (toString$.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  if (toString$.call(xs).slice(8, -1) === 'Object') {
    for (i$ in xs) {
      x = xs[i$];
      if (f(x)) {
        return x;
      }
    }
  } else {
    for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
      x = xs[i$];
      if (f(x)) {
        return x;
      }
    }
  }
});
head = first = function(xs){
  if (!xs.length) {
    return;
  }
  return xs[0];
};
tail = function(xs){
  if (!xs.length) {
    return;
  }
  return xs.slice(1);
};
last = function(xs){
  if (!xs.length) {
    return;
  }
  return xs[xs.length - 1];
};
initial = function(xs){
  if (!xs.length) {
    return;
  }
  return xs.slice(0, xs.length - 1);
};
empty = function(xs){
  var x;
  if (toString$.call(xs).slice(8, -1) === 'Object') {
    for (x in xs) {
      return false;
    }
    return true;
  } else {
    return !xs.length;
  }
};
values = function(obj){
  var i$, x, results$ = [];
  for (i$ in obj) {
    x = obj[i$];
    results$.push(x);
  }
  return results$;
};
keys = function(obj){
  var x, results$ = [];
  for (x in obj) {
    results$.push(x);
  }
  return results$;
};
len = function(xs){
  if (toString$.call(xs).slice(8, -1) === 'Object') {
    xs = values(xs);
  }
  return xs.length;
};
join = curry$(function(sep, xs){
  if (toString$.call(xs).slice(8, -1) === 'Object') {
    xs = values(xs);
  }
  return xs.join(sep);
});
reverse = function(xs){
  if (toString$.call(xs).slice(8, -1) === 'String') {
    return xs.split('').reverse().join('');
  } else {
    return xs.concat().reverse();
  }
};
unique = function(xs){
  var result, i$, x, len$;
  result = [];
  if (toString$.call(xs).slice(8, -1) === 'Object') {
    for (i$ in xs) {
      x = xs[i$];
      if (!in$(x, result)) {
        result.push(x);
      }
    }
  } else {
    for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
      x = xs[i$];
      if (!in$(x, result)) {
        result.push(x);
      }
    }
  }
  if (toString$.call(xs).slice(8, -1) === 'String') {
    return result.join('');
  } else {
    return result;
  }
};
fold = foldl = curry$(function(f, memo, xs){
  var i$, x, len$;
  if (toString$.call(xs).slice(8, -1) === 'Object') {
    for (i$ in xs) {
      x = xs[i$];
      memo = f(memo, x);
    }
  } else {
    for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
      x = xs[i$];
      memo = f(memo, x);
    }
  }
  return memo;
});
fold1 = foldl1 = curry$(function(f, xs){
  return fold(f, xs[0], xs.slice(1));
});
foldr = curry$(function(f, memo, xs){
  return fold(f, memo, xs.concat().reverse());
});
foldr1 = curry$(function(f, xs){
  xs = xs.concat().reverse();
  return fold(f, xs[0], xs.slice(1));
});
unfoldr = unfold = curry$(function(f, b){
  var that;
  if ((that = f(b)) != null) {
    return [that[0]].concat(unfoldr(f, that[1]));
  } else {
    return [];
  }
});
concat = function(xss){
  return fold(curry$(function(x$, y$){
    return x$.concat(y$);
  }), [], xss);
};
concatMap = curry$(function(f, xs){
  return fold(function(memo, x){
    return memo.concat(f(x));
  }, [], xs);
});
flatten = curry$(function(xs){
  var x;
  if (toString$.call(xs).slice(8, -1) === 'Object') {
    xs = values(xs);
  }
  return concat((function(){
    var i$, ref$, len$, ref1$, results$ = [];
    for (i$ = 0, len$ = (ref$ = xs).length; i$ < len$; ++i$) {
      x = ref$[i$];
      if ((ref1$ = toString$.call(x).slice(8, -1)) == 'Array' || ref1$ == 'Arguments') {
        results$.push(flatten(x));
      } else {
        results$.push(x);
      }
    }
    return results$;
  }()));
});
difference = function(arg$){
  var xs, yss, results, i$, len$, x, j$, len1$, ys;
  xs = arg$[0], yss = slice$.call(arg$, 1);
  results = [];
  outer: for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
    x = xs[i$];
    for (j$ = 0, len1$ = yss.length; j$ < len1$; ++j$) {
      ys = yss[j$];
      if (in$(x, ys)) {
        continue outer;
      }
    }
    results.push(x);
  }
  return results;
};
intersection = function(arg$){
  var xs, yss, results, i$, len$, x, j$, len1$, ys;
  xs = arg$[0], yss = slice$.call(arg$, 1);
  results = [];
  outer: for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
    x = xs[i$];
    for (j$ = 0, len1$ = yss.length; j$ < len1$; ++j$) {
      ys = yss[j$];
      if (!in$(x, ys)) {
        continue outer;
      }
    }
    results.push(x);
  }
  return results;
};
union = function(xss){
  var results, i$, len$, xs, j$, len1$, x;
  results = [];
  for (i$ = 0, len$ = xss.length; i$ < len$; ++i$) {
    xs = xss[i$];
    for (j$ = 0, len1$ = xs.length; j$ < len1$; ++j$) {
      x = xs[j$];
      if (!in$(x, results)) {
        results.push(x);
      }
    }
  }
  return results;
};
countBy = curry$(function(f, xs){
  var results, i$, len$, x, key;
  results = {};
  for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
    x = xs[i$];
    key = f(x);
    if (key in results) {
      results[key] += 1;
    } else {
      results[key] = 1;
    }
  }
  return results;
});
groupBy = curry$(function(f, xs){
  var results, i$, len$, x, key;
  results = {};
  for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
    x = xs[i$];
    key = f(x);
    if (key in results) {
      results[key].push(x);
    } else {
      results[key] = [x];
    }
  }
  return results;
});
andList = function(xs){
  var i$, len$, x;
  for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
    x = xs[i$];
    if (!x) {
      return false;
    }
  }
  return true;
};
orList = function(xs){
  var i$, len$, x;
  for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
    x = xs[i$];
    if (x) {
      return true;
    }
  }
  return false;
};
any = curry$(function(f, xs){
  var i$, len$, x;
  if (toString$.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
    x = xs[i$];
    if (f(x)) {
      return true;
    }
  }
  return false;
});
all = curry$(function(f, xs){
  var i$, len$, x;
  if (toString$.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
    x = xs[i$];
    if (!f(x)) {
      return false;
    }
  }
  return true;
});
compare = curry$(function(f, x, y){
  switch (false) {
  case !(f(x) > f(y)):
    return 1;
  case !(f(x) < f(y)):
    return -1;
  default:
    return 0;
  }
});
sort = function(xs){
  return xs.concat().sort(function(x, y){
    switch (false) {
    case !(x > y):
      return 1;
    case !(x < y):
      return -1;
    default:
      return 0;
    }
  });
};
sortWith = curry$(function(f, xs){
  if (!xs.length) {
    return [];
  }
  return xs.concat().sort(f);
});
sortBy = curry$(function(f, xs){
  if (!xs.length) {
    return [];
  }
  return xs.concat().sort(compare(f));
});
sum = function(xs){
  var result, i$, x, len$;
  result = 0;
  if (toString$.call(xs).slice(8, -1) === 'Object') {
    for (i$ in xs) {
      x = xs[i$];
      result += x;
    }
  } else {
    for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
      x = xs[i$];
      result += x;
    }
  }
  return result;
};
product = function(xs){
  var result, i$, x, len$;
  result = 1;
  if (toString$.call(xs).slice(8, -1) === 'Object') {
    for (i$ in xs) {
      x = xs[i$];
      result *= x;
    }
  } else {
    for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
      x = xs[i$];
      result *= x;
    }
  }
  return result;
};
mean = average = function(xs){
  return sum(xs) / len(xs);
};
maximum = function(xs){
  return fold1(curry$(function(x$, y$){
    return x$ > y$ ? x$ : y$;
  }), xs);
};
minimum = function(xs){
  return fold1(curry$(function(x$, y$){
    return x$ < y$ ? x$ : y$;
  }), xs);
};
scan = scanl = curry$(function(f, memo, xs){
  var last, x;
  last = memo;
  if (toString$.call(xs).slice(8, -1) === 'Object') {
    return [memo].concat((function(){
      var i$, ref$, results$ = [];
      for (i$ in ref$ = xs) {
        x = ref$[i$];
        results$.push(last = f(last, x));
      }
      return results$;
    }()));
  } else {
    return [memo].concat((function(){
      var i$, ref$, len$, results$ = [];
      for (i$ = 0, len$ = (ref$ = xs).length; i$ < len$; ++i$) {
        x = ref$[i$];
        results$.push(last = f(last, x));
      }
      return results$;
    }()));
  }
});
scan1 = scanl1 = curry$(function(f, xs){
  return scan(f, xs[0], xs.slice(1));
});
scanr = curry$(function(f, memo, xs){
  xs = xs.slice().reverse();
  return scan(f, memo, xs).reverse();
});
scanr1 = curry$(function(f, xs){
  xs = xs.slice().reverse();
  return scan(f, xs[0], xs.slice(1)).reverse();
});
replicate = curry$(function(n, x){
  var i$, results$ = [];
  for (i$ = 0; i$ < n; ++i$) {
    results$.push(x);
  }
  return results$;
});
take = curry$(function(n, xs){
  if (n <= 0) {
    if (toString$.call(xs).slice(8, -1) === 'String') {
      return '';
    } else {
      return [];
    }
  } else if (!xs.length) {
    return xs;
  } else {
    return xs.slice(0, n);
  }
});
drop = curry$(function(n, xs){
  if (n <= 0 || !xs.length) {
    return xs;
  } else {
    return xs.slice(n);
  }
});
splitAt = curry$(function(n, xs){
  return [take(n, xs), drop(n, xs)];
});
takeWhile = curry$(function(p, xs){
  var result, i$, len$, x;
  if (!xs.length) {
    return xs;
  }
  if (toString$.call(p).slice(8, -1) !== 'Function') {
    p = objToFunc(p);
  }
  result = [];
  for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
    x = xs[i$];
    if (!p(x)) {
      break;
    }
    result.push(x);
  }
  if (toString$.call(xs).slice(8, -1) === 'String') {
    return result.join('');
  } else {
    return result;
  }
});
dropWhile = curry$(function(p, xs){
  var i, i$, len$, x;
  if (!xs.length) {
    return xs;
  }
  if (toString$.call(p).slice(8, -1) !== 'Function') {
    p = objToFunc(p);
  }
  i = 0;
  for (i$ = 0, len$ = xs.length; i$ < len$; ++i$) {
    x = xs[i$];
    if (!p(x)) {
      break;
    }
    ++i;
  }
  return drop(i, xs);
});
span = curry$(function(p, xs){
  return [takeWhile(p, xs), dropWhile(p, xs)];
});
breakList = curry$(function(p, xs){
  return span(compose$([not$, p]), xs);
});
zip = curry$(function(xs, ys){
  var result, i$, ref$, len$, i, zs, j$, len1$, j, z, ref1$;
  result = [];
  for (i$ = 0, len$ = (ref$ = [xs, ys]).length; i$ < len$; ++i$) {
    i = i$;
    zs = ref$[i$];
    for (j$ = 0, len1$ = zs.length; j$ < len1$; ++j$) {
      j = j$;
      z = zs[j$];
      if (i === 0) {
        result.push([]);
      }
      if ((ref1$ = result[j]) != null) {
        ref1$.push(z);
      }
    }
  }
  return result;
});
zipWith = curry$(function(f, xs, ys){
  var i$, ref$, len$, zs, results$ = [];
  if (toString$.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  if (!xs.length || !ys.length) {
    return [];
  } else {
    for (i$ = 0, len$ = (ref$ = zip.call(this, xs, ys)).length; i$ < len$; ++i$) {
      zs = ref$[i$];
      results$.push(f.apply(this, zs));
    }
    return results$;
  }
});
zipAll = function(){
  var xss, result, i$, len$, i, xs, j$, len1$, j, x, ref$;
  xss = slice$.call(arguments);
  result = [];
  for (i$ = 0, len$ = xss.length; i$ < len$; ++i$) {
    i = i$;
    xs = xss[i$];
    for (j$ = 0, len1$ = xs.length; j$ < len1$; ++j$) {
      j = j$;
      x = xs[j$];
      if (i === 0) {
        result.push([]);
      }
      if ((ref$ = result[j]) != null) {
        ref$.push(x);
      }
    }
  }
  return result;
};
zipAllWith = function(f){
  var xss, i$, ref$, len$, xs, results$ = [];
  xss = slice$.call(arguments, 1);
  if (toString$.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  if (!xss[0].length || !xss[1].length) {
    return [];
  } else {
    for (i$ = 0, len$ = (ref$ = zipAll.apply(this, xss)).length; i$ < len$; ++i$) {
      xs = ref$[i$];
      results$.push(f.apply(this, xs));
    }
    return results$;
  }
};
curry = function(f){
  return curry$(f);
};
id = function(x){
  return x;
};
flip = curry$(function(f, x, y){
  return f(y, x);
});
fix = function(f){
  return function(g, x){
    return function(){
      return f(g(g)).apply(null, arguments);
    };
  }(function(g, x){
    return function(){
      return f(g(g)).apply(null, arguments);
    };
  });
};
split = curry$(function(sep, str){
  return str.split(sep);
});
lines = function(str){
  if (!str.length) {
    return [];
  }
  return str.split('\n');
};
unlines = function(it){
  return it.join('\n');
};
words = function(str){
  if (!str.length) {
    return [];
  }
  return str.split(/[ ]+/);
};
unwords = function(it){
  return it.join(' ');
};
chars = function(it){
  return it.split('');
};
unchars = function(it){
  return it.join('');
};
max = curry$(function(x$, y$){
  return x$ > y$ ? x$ : y$;
});
min = curry$(function(x$, y$){
  return x$ < y$ ? x$ : y$;
});
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
quot = curry$(function(x, y){
  return ~~(x / y);
});
rem = curry$(function(x$, y$){
  return x$ % y$;
});
div = curry$(function(x, y){
  return Math.floor(x / y);
});
mod = curry$(function(x$, y$){
  var ref$;
  return ((x$) % (ref$ = y$) + ref$) % ref$;
});
recip = (function(it){
  return 1 / it;
});
pi = Math.PI;
tau = pi * 2;
exp = Math.exp;
sqrt = Math.sqrt;
ln = Math.log;
pow = curry$(function(x$, y$){
  return Math.pow(x$, y$);
});
sin = Math.sin;
tan = Math.tan;
cos = Math.cos;
asin = Math.asin;
acos = Math.acos;
atan = Math.atan;
atan2 = curry$(function(x, y){
  return Math.atan2(x, y);
});
truncate = function(x){
  return ~~x;
};
round = Math.round;
ceiling = Math.ceil;
floor = Math.floor;
isItNaN = function(x){
  return x !== x;
};
even = function(x){
  return x % 2 === 0;
};
odd = function(x){
  return x % 2 !== 0;
};
gcd = curry$(function(x, y){
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
lcm = curry$(function(x, y){
  return Math.abs(Math.floor(x / gcd(x, y) * y));
});
prelude = {
  each: each,
  map: map,
  filter: filter,
  compact: compact,
  reject: reject,
  partition: partition,
  find: find,
  head: head,
  first: first,
  tail: tail,
  last: last,
  initial: initial,
  empty: empty,
  values: values,
  keys: keys,
  len: len,
  join: join,
  split: split,
  reverse: reverse,
  difference: difference,
  intersection: intersection,
  union: union,
  countBy: countBy,
  groupBy: groupBy,
  fold: fold,
  fold1: fold1,
  foldl: foldl,
  foldl1: foldl1,
  foldr: foldr,
  foldr1: foldr1,
  unfoldr: unfoldr,
  andList: andList,
  orList: orList,
  any: any,
  all: all,
  unique: unique,
  compare: compare,
  sort: sort,
  sortWith: sortWith,
  sortBy: sortBy,
  sum: sum,
  product: product,
  mean: mean,
  average: average,
  concat: concat,
  concatMap: concatMap,
  flatten: flatten,
  maximum: maximum,
  minimum: minimum,
  scan: scan,
  scan1: scan1,
  scanl: scanl,
  scanl1: scanl1,
  scanr: scanr,
  scanr1: scanr1,
  replicate: replicate,
  take: take,
  drop: drop,
  splitAt: splitAt,
  takeWhile: takeWhile,
  dropWhile: dropWhile,
  span: span,
  breakList: breakList,
  listToObj: listToObj,
  objToFunc: objToFunc,
  zip: zip,
  zipWith: zipWith,
  zipAll: zipAll,
  zipAllWith: zipAllWith,
  curry: curry,
  id: id,
  flip: flip,
  fix: fix,
  lines: lines,
  unlines: unlines,
  words: words,
  unwords: unwords,
  chars: chars,
  unchars: unchars,
  max: max,
  min: min,
  negate: negate,
  abs: abs,
  signum: signum,
  quot: quot,
  rem: rem,
  div: div,
  mod: mod,
  recip: recip,
  pi: pi,
  tau: tau,
  exp: exp,
  sqrt: sqrt,
  ln: ln,
  pow: pow,
  sin: sin,
  tan: tan,
  acos: acos,
  asin: asin,
  atan: atan,
  atan2: atan2,
  truncate: truncate,
  round: round,
  ceiling: ceiling,
  floor: floor,
  isItNaN: isItNaN,
  even: even,
  odd: odd,
  gcd: gcd,
  lcm: lcm
};
prelude.prelude = prelude;
prelude.installPrelude = function(target){
  var ref$;
  if (!((ref$ = target.prelude) != null && ref$.isInstalled)) {
    import$(target, prelude);
    import$(target, target.prelude.isInstalled = true);
  }
};
if (typeof exports != 'undefined' && exports !== null) {
  exports = prelude;
}
function curry$(f, bound){
  var context,
  _curry = function(args) {
    return f.length > 1 ? function(){
      var params = args ? args.concat() : [];
      context = bound ? context || this : this;
      return params.push.apply(params, arguments) <
          f.length && arguments.length ?
        _curry.call(context, params) : f.apply(context, params);
    } : f;
  };
  return _curry();
}
function in$(x, arr){
  var i = -1, l = arr.length >>> 0;
  while (++i < l) if (x === arr[i] && i in arr) return true;
  return false;
}
function compose$(fs){
  return function(){
    var i, args = arguments;
    for (i = fs.length; i > 0; --i) { args = [fs[i-1].apply(this, args)]; }
    return args[0];
  };
}
function not$(x){ return !x; }
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}