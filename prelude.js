// prelude.ls 0.1.0
// Copyright (c) 2012 George Zahariev
// Released under the MIT License
// raw.github.com/gkz/prelude-ls/master/LICNSE
var compose, max, min, negate, abs, signum, quot, rem, div, mod, recip, pi, exp, sqrt, log, pow, sin, tan, cos, asin, atan, atan2, acos, truncate, round, ceiling, floor, isItNaN, even, odd, gcd, lcm, id, flip, error, each, map, cons, append, filter, reject, find, pluck, head, tail, last, initial, empty, length, reverse, foldl, fold, foldl1, fold1, foldr, foldr1, andList, orList, any, all, sum, product, average, mean, concat, concatMap, maximum, minimum, scanl, scan, scanl1, scan1, scanr, scanr1, replicate, take, drop, splitAt, takeWhile, dropWhile, span, breakList, elem, notElem, lookup, call, zip, zipWith, lines, unlines, words, unwords, __slice = [].slice;
exports.compose = compose = function(){
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
exports.max = max = __curry(function(x, y){
  return Math.max(x, y);
});
exports.min = min = __curry(function(x, y){
  return Math.min(x, y);
});
exports.negate = negate = function(x){
  return -x;
};
exports.abs = abs = Math.abs;
exports.signum = signum = function(x){
  switch (false) {
  case !(x < 0):
    return -1;
  case !(x > 0):
    return 1;
  default:
    return 0;
  }
};
exports.quot = quot = __curry(function(x, y){
  return ~~(x / y);
});
exports.rem = rem = __curry(function(x, y){
  return x % y;
});
exports.div = div = __curry(function(x, y){
  return Math.floor(x / y);
});
exports.mod = mod = __curry(function(x, y){
  var __ref;
  return ((x) % (__ref = y) + __ref) % __ref;
});
exports.recip = recip = function(x){
  return 1 / x;
};
exports.pi = pi = Math.PI;
exports.exp = exp = Math.exp;
exports.sqrt = sqrt = Math.sqrt;
exports.log = log = Math.log;
exports.pow = pow = __curry(function(x, y){
  return Math.pow(x, y);
});
exports.sin = sin = Math.sin;
exports.tan = tan = Math.tan;
exports.cos = cos = Math.cos;
exports.asin = asin = Math.asin;
exports.atan = atan = Math.atan;
exports.atan2 = atan2 = __curry(function(x, y){
  return Math.atan2(x, y);
});
exports.acos = acos = Math.acos;
exports.truncate = truncate = function(x){
  return ~~x;
};
exports.round = round = Math.round;
exports.ceiling = ceiling = Math.ceil;
exports.floor = floor = Math.floor;
exports.isItNaN = isItNaN = function(x){
  return x !== x;
};
exports.even = even = function(x){
  return x % 2 === 0;
};
exports.odd = odd = function(x){
  return x % 2 !== 0;
};
exports.gcd = gcd = __curry(function(x, y){
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
exports.lcm = lcm = __curry(function(x, y){
  return Math.abs(Math.floor(x / gcd(x, y) * y));
});
exports.id = id = function(x){
  return x;
};
exports.flip = flip = __curry(function(f, x, y){
  return f(y, x);
});
exports.error = error = function(msg){
  throw msg;
};
exports.each = each = __curry(function(f, xs){
  var x, __i, __len;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    f(x);
  }
  return xs;
});
exports.map = map = __curry(function(f, xs){
  var result, x, __i, __len;
  result = [];
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    result.push(f(x));
  }
  return result;
});
exports.cons = cons = __curry(function(x, xs){
  return [(x)].concat(xs);
});
exports.append = append = __curry(function(xs, ys){
  return (xs).concat(ys);
});
exports.filter = filter = __curry(function(f, xs){
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
exports.reject = reject = __curry(function(f, xs){
  var result, x, __i, __len;
  result = [];
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    if (!f(x)) {
      result.push(x);
    }
  }
  return result;
});
exports.find = find = __curry(function(f, xs){
  var x, __i, __len;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    if (f(x)) {
      return x;
    }
  }
});
exports.pluck = pluck = __curry(function(prop, xs){
  var result, x, __i, __len;
  result = [];
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    if (x[prop] != null) {
      result.push(x[prop]);
    }
  }
  return result;
});
exports.head = head = function(xs){
  if (!xs.length) {
    return;
  }
  return xs.slice(0, 1);
};
exports.tail = tail = function(xs){
  if (!xs.length) {
    return;
  }
  return xs.slice(1);
};
exports.last = last = function(xs){
  if (!xs.length) {
    return;
  }
  return xs.slice(xs.length - 1);
};
exports.initial = initial = function(xs){
  if (!xs.length) {
    return;
  }
  return xs.slice(0, xs.length - 1);
};
exports.empty = empty = function(xs){
  return !xs.length;
};
exports.length = length = function(xs){
  return xs.length;
};
exports.reverse = reverse = function(xs){
  return xs.slice().reverse();
};
exports.fold = fold = exports.foldl = foldl = __curry(function(f, memo, xs){
  var x, __i, __len;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    memo = f(memo, x);
  }
  return memo;
});
exports.fold1 = fold1 = exports.foldl1 = foldl1 = __curry(function(f, xs){
  return fold(f, xs[0], xs.slice(1));
});
exports.foldr = foldr = __curry(function(f, memo, xs){
  return fold(f, memo, xs.reverse());
});
exports.foldr1 = foldr1 = __curry(function(f, xs){
  xs.reverse();
  return fold(f, xs[0], xs.slice(1));
});
exports.andList = andList = function(xs){
  return fold(function(memo, x){
    return memo && x;
  }, true, xs);
};
exports.orList = orList = function(xs){
  return fold(function(memo, x){
    return memo || x;
  }, false, xs);
};
exports.any = any = __curry(function(f, xs){
  return fold(function(memo, x){
    return memo || f(x);
  }, false, xs);
});
exports.all = all = __curry(function(f, xs){
  return fold(function(memo, x){
    return memo && f(x);
  }, true, xs);
});
exports.sum = sum = function(xs){
  var result, x, __i, __len;
  result = 0;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    result += x;
  }
  return result;
};
exports.product = product = function(xs){
  var result, x, __i, __len;
  result = 1;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    result *= x;
  }
  return result;
};
exports.mean = mean = exports.average = average = function(xs){
  var sum, x, __i, __len;
  sum = 0;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    sum += x;
  }
  return sum / xs.length;
};
exports.concat = concat = function(xss){
  return fold(append, [], xss);
};
exports.concatMap = concatMap = __curry(function(f, xs){
  return concat(map(f, xs));
});
exports.maximum = maximum = function(xs){
  if (!xs.length) {
    return;
  }
  return Math.max.apply(this, xs);
};
exports.minimum = minimum = function(xs){
  if (!xs.length) {
    return;
  }
  return Math.min.apply(this, xs);
};
exports.scan = scan = exports.scanl = scanl = __curry(function(f, memo, xs){
  var result, last, x, __i, __len;
  result = [memo];
  last = memo;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    result.push(last = f(last, x));
  }
  return result;
});
exports.scan1 = scan1 = exports.scanl1 = scanl1 = __curry(function(f, xs){
  return scan(f, xs[0], xs.slice(1));
});
exports.scanr = scanr = __curry(function(f, memo, xs){
  xs.reverse();
  return scan(f, memo, xs).reverse();
});
exports.scanr1 = scanr1 = __curry(function(f, xs){
  xs.reverse();
  return scan(f, xs[0], xs.slice(1)).reverse();
});
exports.replicate = replicate = __curry(function(n, x){
  var result, i;
  result = [];
  i = 0;
  for (; i < n; ++i) {
    result.push(x);
  }
  return result;
});
exports.take = take = __curry(function(n, xs){
  switch (false) {
  case !(n <= 0):
    return [];
  case !!xs.length:
    return [];
  default:
    return xs.slice(0, n);
  }
});
exports.drop = drop = __curry(function(n, xs){
  switch (false) {
  case !(n <= 0):
    return xs;
  case !!xs.length:
    return [];
  default:
    return xs.slice(n);
  }
});
exports.splitAt = splitAt = __curry(function(n, xs){
  return [take(n, xs), drop(n, xs)];
});
exports.takeWhile = takeWhile = __curry(function(p, xs){
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
exports.dropWhile = dropWhile = __curry(function(p, xs){
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
exports.span = span = __curry(function(p, xs){
  return [takeWhile(p, xs), dropWhile(p, xs)];
});
exports.breakList = breakList = __curry(function(p, xs){
  return span(__compose((function(it){
    return !it;
  }),(p)), xs);
});
exports.elem = elem = __curry(function(x, ys){
  return __in(x, ys);
});
exports.notElem = notElem = __curry(function(x, ys){
  return !__in(x, ys);
});
exports.lookup = lookup = __curry(function(key, xs){
  return xs != null ? xs[key] : void 8;
});
exports.call = call = __curry(function(key, xs){
  return xs != null ? typeof xs[key] === 'function' ? xs[key]() : void 8 : void 8;
});
exports.zip = zip = function(){
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
exports.zipWith = zipWith = function(f){
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
exports.lines = lines = function(str){
  if (!str.length) {
    return [];
  }
  return str.split('\n');
};
exports.unlines = unlines = function(strs){
  return strs.join('\n');
};
exports.words = words = function(str){
  if (!str.length) {
    return [];
  }
  return str.split(' ');
};
exports.unwords = unwords = function(strs){
  return strs.join(' ');
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