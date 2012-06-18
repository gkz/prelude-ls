// prelude.ls 0.3.0
// Copyright (c) 2012 George Zahariev
// Released under the MIT License
// raw.github.com/gkz/prelude-ls/master/LICNSE
var objToFunc, each, map, filter, reject, partition, find, pluck, first, head, tail, last, initial, empty, values, keys, length, cons, append, join, reverse, foldl, fold, foldl1, fold1, foldr, foldr1, andList, orList, any, all, unique, sum, product, average, mean, concat, concatMap, listToObj, maximum, minimum, scanl, scan, scanl1, scan1, scanr, scanr1, replicate, take, drop, splitAt, takeWhile, dropWhile, span, breakIt, lookup, call, zip, zipWith, compose, curry, partial, id, flip, lines, unlines, words, unwords, max, min, negate, abs, signum, quot, rem, div, mod, recip, pi, tau, exp, sqrt, ln, pow, sin, tan, cos, asin, acos, atan, atan2, truncate, round, ceiling, floor, isItNaN, even, odd, gcd, lcm, __toString = {}.toString, __slice = [].slice;
exports.objToFunc = objToFunc = function(obj){
  return function(key){
    return obj[key];
  };
};
exports.each = each = __curry(function(f, xs){
  var x, __i, __len;
  if (__toString.call(xs).slice(8, -1) === 'Object') {
    for (__i in xs) {
      x = xs[__i];
      f(x);
    }
  } else {
    for (__i = 0, __len = xs.length; __i < __len; ++__i) {
      x = xs[__i];
      f(x);
    }
  }
  return xs;
});
exports.map = map = __curry(function(f, xs){
  var type, key, x, result, __res, __i, __len, __results = {};
  if (__toString.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  type = __toString.call(xs).slice(8, -1);
  if (type === 'Object') {
    for (key in xs) {
      x = xs[key];
      __results[key] = f(x);
    }
    return __results;
  } else {
    __res = [];
    for (__i = 0, __len = xs.length; __i < __len; ++__i) {
      x = xs[__i];
      __res.push(f(x));
    }
    result = __res;
    if (type === 'String') {
      return result.join('');
    } else {
      return result;
    }
  }
});
exports.filter = filter = __curry(function(f, xs){
  var type, key, x, result, __res, __i, __len, __results = {};
  if (__toString.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  type = __toString.call(xs).slice(8, -1);
  if (type === 'Object') {
    for (key in xs) {
      x = xs[key];
if (f(x)) {
        __results[key] = x;
      }
    }
    return __results;
  } else {
    __res = [];
    for (__i = 0, __len = xs.length; __i < __len; ++__i) {
      x = xs[__i];
      if (f(x)) {
        __res.push(x);
      }
    }
    result = __res;
    if (type === 'String') {
      return result.join('');
    } else {
      return result;
    }
  }
});
exports.reject = reject = __curry(function(f, xs){
  var type, key, x, result, __res, __i, __len, __results = {};
  if (__toString.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  type = __toString.call(xs).slice(8, -1);
  if (type === 'Object') {
    for (key in xs) {
      x = xs[key];
if (!f(x)) {
        __results[key] = x;
      }
    }
    return __results;
  } else {
    __res = [];
    for (__i = 0, __len = xs.length; __i < __len; ++__i) {
      x = xs[__i];
      if (!f(x)) {
        __res.push(x);
      }
    }
    result = __res;
    if (type === 'String') {
      return result.join('');
    } else {
      return result;
    }
  }
});
exports.partition = partition = __curry(function(f, xs){
  var type, passed, failed, key, x, __i, __len;
  if (__toString.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  type = __toString.call(xs).slice(8, -1);
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
    for (__i = 0, __len = xs.length; __i < __len; ++__i) {
      x = xs[__i];
      (f(x) ? passed : failed).push(x);
    }
    if (type === 'String') {
      passed = passed.join('');
      failed = failed.join('');
    }
  }
  return [passed, failed];
});
exports.find = find = __curry(function(f, xs){
  var x, __i, __len;
  if (__toString.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  if (__toString.call(xs).slice(8, -1) === 'Object') {
    for (__i in xs) {
      x = xs[__i];
      if (f(x)) {
        return x;
      }
    }
  } else {
    for (__i = 0, __len = xs.length; __i < __len; ++__i) {
      x = xs[__i];
      if (f(x)) {
        return x;
      }
    }
  }
});
exports.pluck = pluck = __curry(function(prop, xs){
  var key, x, __i, __len, __results = [];
  if (__toString.call(xs).slice(8, -1) === 'Object') {
    for (key in xs) {
      x = xs[key];
if (x[prop] != null) {
        __results[key] = x[prop];
      }
    }
    return __results;
  } else {
    for (__i = 0, __len = xs.length; __i < __len; ++__i) {
      x = xs[__i];
      if (x[prop] != null) {
        __results.push(x[prop]);
      }
    }
    return __results;
  }
});
exports.head = head = exports.first = first = function(xs){
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
  var x;
  if (__toString.call(xs).slice(8, -1) === 'Object') {
    for (x in xs) {
      return false;
    }
    return true;
  }
  return !xs.length;
};
exports.values = values = function(obj){
  var x, __i, __results = [];
  for (__i in obj) {
    x = obj[__i];
    __results.push(x);
  }
  return __results;
};
exports.keys = keys = function(obj){
  var x, __results = [];
  for (x in obj) {
    __results.push(x);
  }
  return __results;
};
exports.length = length = function(xs){
  if (__toString.call(xs).slice(8, -1) === 'Object') {
    xs = values(xs);
  }
  return xs.length;
};
exports.cons = cons = __curry(function(x, xs){
  if (__toString.call(xs).slice(8, -1) === 'String') {
    return x + xs;
  } else {
    return [(x)].concat(xs);
  }
});
exports.append = append = __curry(function(xs, ys){
  if (__toString.call(ys).slice(8, -1) === 'String') {
    return xs + ys;
  } else {
    return (xs).concat(ys);
  }
});
exports.join = join = __curry(function(sep, xs){
  if (__toString.call(xs).slice(8, -1) === 'Object') {
    xs = values(xs);
  }
  return xs.join(sep);
});
exports.reverse = reverse = function(xs){
  if (__toString.call(xs).slice(8, -1) === 'String') {
    return xs.split('').reverse().join('');
  } else {
    return xs.slice().reverse();
  }
};
exports.fold = fold = exports.foldl = foldl = __curry(function(f, memo, xs){
  var x, __i, __len;
  if (__toString.call(xs).slice(8, -1) === 'Object') {
    for (__i in xs) {
      x = xs[__i];
      memo = f(memo, x);
    }
  } else {
    for (__i = 0, __len = xs.length; __i < __len; ++__i) {
      x = xs[__i];
      memo = f(memo, x);
    }
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
  if (__toString.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  return fold(function(memo, x){
    return memo || f(x);
  }, false, xs);
});
exports.all = all = __curry(function(f, xs){
  if (__toString.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  return fold(function(memo, x){
    return memo && f(x);
  }, true, xs);
});
exports.unique = unique = function(xs){
  var result, x, __i, __len;
  result = [];
  if (__toString.call(xs).slice(8, -1) === 'Object') {
    for (__i in xs) {
      x = xs[__i];
      if (!__in(x, result)) {
        result.push(x);
      }
    }
  } else {
    for (__i = 0, __len = xs.length; __i < __len; ++__i) {
      x = xs[__i];
      if (!__in(x, result)) {
        result.push(x);
      }
    }
  }
  if (__toString.call(xs).slice(8, -1) === 'String') {
    return result.join('');
  } else {
    return result;
  }
};
exports.sum = sum = function(xs){
  var result, x, __i, __len;
  result = 0;
  if (__toString.call(xs).slice(8, -1) === 'Object') {
    for (__i in xs) {
      x = xs[__i];
      result += x;
    }
  } else {
    for (__i = 0, __len = xs.length; __i < __len; ++__i) {
      x = xs[__i];
      result += x;
    }
  }
  return result;
};
exports.product = product = function(xs){
  var result, x, __i, __len;
  result = 1;
  if (__toString.call(xs).slice(8, -1) === 'Object') {
    for (__i in xs) {
      x = xs[__i];
      result *= x;
    }
  } else {
    for (__i = 0, __len = xs.length; __i < __len; ++__i) {
      x = xs[__i];
      result *= x;
    }
  }
  return result;
};
exports.mean = mean = exports.average = average = function(xs){
  return sum(xs) / length(xs);
};
exports.concat = concat = function(xss){
  return fold(append, [], xss);
};
exports.concatMap = concatMap = __curry(function(f, xs){
  return concat(map(f, xs));
});
exports.listToObj = listToObj = function(xs){
  var result, x, __i, __len;
  result = {};
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    result[x[0]] = x[1];
  }
  return result;
};
exports.maximum = maximum = function(xs){
  return fold1(max, xs);
};
exports.minimum = minimum = function(xs){
  return fold1(min, xs);
};
exports.scan = scan = exports.scanl = scanl = __curry(function(f, memo, xs){
  var last, x;
  last = memo;
  if (__toString.call(xs).slice(8, -1) === 'Object') {
    return ([memo]).concat((function(){
      var __i, __ref, __results = [];
      for (__i in __ref = xs) {
        x = __ref[__i];
        __results.push(last = f(last, x));
      }
      return __results;
    }()));
  } else {
    return ([memo]).concat((function(){
      var __i, __ref, __len, __results = [];
      for (__i = 0, __len = (__ref = xs).length; __i < __len; ++__i) {
        x = __ref[__i];
        __results.push(last = f(last, x));
      }
      return __results;
    }()));
  }
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
  if (__toString.call(x).slice(8, -1) === 'String') {
    return result.join('');
  } else {
    return result;
  }
});
exports.take = take = __curry(function(n, xs){
  switch (false) {
  case !(n <= 0):
    if (__toString.call(xs).slice(8, -1) === 'String') {
      return '';
    } else {
      return [];
    }
    break;
  case !!xs.length:
    return xs;
  default:
    return xs.slice(0, n);
  }
});
exports.drop = drop = __curry(function(n, xs){
  switch (false) {
  case !(n <= 0):
    return xs;
  case !!xs.length:
    return xs;
  default:
    return xs.slice(n);
  }
});
exports.splitAt = splitAt = __curry(function(n, xs){
  return [take(n, xs), drop(n, xs)];
});
exports.takeWhile = takeWhile = __curry(function(p, xs){
  var result, x, __i, __len;
  if (!xs.length) {
    return xs;
  }
  if (__toString.call(p).slice(8, -1) !== 'Function') {
    p = objToFunc(p);
  }
  result = [];
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    if (!p(x)) {
      break;
    }
    result.push(x);
  }
  if (__toString.call(xs).slice(8, -1) === 'String') {
    return result.join('');
  } else {
    return result;
  }
});
exports.dropWhile = dropWhile = __curry(function(p, xs){
  var i, x, __i, __len;
  if (!xs.length) {
    return xs;
  }
  if (__toString.call(p).slice(8, -1) !== 'Function') {
    p = objToFunc(p);
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
exports.breakIt = breakIt = __curry(function(p, xs){
  return span(__compose((__not),(p)), xs);
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
  var xss, xs, __i, __ref, __len, __results = [];
  xss = __slice.call(arguments, 1);
  if (__toString.call(f).slice(8, -1) !== 'Function') {
    f = objToFunc(f);
  }
  if (!xss[0].length || !xss[1].length) {
    return [];
  } else {
    for (__i = 0, __len = (__ref = zip.apply(this, xss)).length; __i < __len; ++__i) {
      xs = __ref[__i];
      __results.push(f.apply(this, xs));
    }
    return __results;
  }
};
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
exports.curry = curry = function(f){
  return __curry(f);
};
exports.partial = partial = function(f){
  var initArgs;
  initArgs = __slice.call(arguments, 1);
  return function(){
    var args;
    args = __slice.call(arguments);
    return f.apply(this, (initArgs).concat(args));
  };
};
exports.id = id = function(x){
  return x;
};
exports.flip = flip = __curry(function(f, x, y){
  return f(y, x);
});
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
  return str.split(/[ ]+/);
};
exports.unwords = unwords = function(strs){
  return strs.join(' ');
};
exports.max = max = __curry(function(x, y){
  if (x > y) {
    return x;
  } else {
    return y;
  }
});
exports.min = min = __curry(function(x, y){
  if (x > y) {
    return y;
  } else {
    return x;
  }
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
exports.tau = tau = pi * 2;
exports.exp = exp = Math.exp;
exports.sqrt = sqrt = Math.sqrt;
exports.ln = ln = Math.log;
exports.pow = pow = __curry(function(x, y){
  return Math.pow(x, y);
});
exports.sin = sin = Math.sin;
exports.tan = tan = Math.tan;
exports.cos = cos = Math.cos;
exports.asin = asin = Math.asin;
exports.acos = acos = Math.acos;
exports.atan = atan = Math.atan;
exports.atan2 = atan2 = __curry(function(x, y){
  return Math.atan2(x, y);
});
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
exports.installPrelude = function(target){
  __import(target, exports);
};
exports.prelude = exports;
function __curry(f, args){
  return f.length > 1 ? function(){
    var params = args ? args.concat() : [];
    return params.push.apply(params, arguments) < f.length && arguments.length ?
      __curry.call(this, f, params) : f.apply(this, params);
  } : f;
}
function __in(x, arr){
  var i = 0, l = arr.length >>> 0;
  while (i < l) if (x === arr[i++]) return true;
  return false;
}
function __compose(f, g){
  return function(){
    return f(g.apply(this, arguments)); 
  }
}
function __not(x){ return !x; }
function __import(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}