var __slice = [].slice;
exports.contradict = function(x){
  return !x;
};
exports.equals = __curry(function(x, y){
  return x === y;
});
exports.notEquals = __curry(function(x, y){
  return x !== y;
});
exports.lt = __curry(function(x, y){
  return x > y;
});
exports.lte = __curry(function(x, y){
  return x >= y;
});
exports.gt = __curry(function(x, y){
  return x < y;
});
exports.gte = __curry(function(x, y){
  return x <= y;
});
exports.andTest = __curry(function(x, y){
  return x && y;
});
exports.orTest = __curry(function(x, y){
  return x || y;
});
exports.compose = function(){
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
exports.max = Math.max;
exports.min = Math.min;
exports.negate = function(x){
  return -x;
};
exports.abs = Math.abs;
exports.signum = function(x){
  switch (false) {
  case !(x < 0):
    return -1;
  case !(x > 0):
    return 1;
  default:
    return 0;
  }
};
exports.quot = __curry(function(x, y){
  return ~~(x / y);
});
exports.rem = __curry(function(x, y){
  return x % y;
});
exports.div = __curry(function(x, y){
  return Math.floor(x / y);
});
exports.mod = __curry(function(x, y){
  var __ref;
  return ((x) % (__ref = y) + __ref) % __ref;
});
exports.recip = function(x){
  return 1 / x;
};
exports.pi = Math.PI;
exports.exp = Math.exp;
exports.sqrt = Math.sqrt;
exports.log = Math.log;
exports.pow = __curry(function(x, y){
  return Math.pow(x, y);
});
exports.sin = Math.sin;
exports.tan = Math.tan;
exports.cos = Math.cos;
exports.asin = Math.asin;
exports.atan = Math.atan;
exports.atan2 = __curry(function(x, y){
  return Math.atan2(x, y);
});
exports.acos = Math.acos;
exports.truncate = function(x){
  return ~~x;
};
exports.round = Math.round;
exports.ceiling = Math.ceil;
exports.floor = Math.floor;
exports.isItNaN = function(x){
  return x !== x;
};
exports.add = __curry(function(x, y){
  return x + y;
});
exports.minus = __curry(function(x, y){
  return x - y;
});
exports.subtract = __curry(function(x, y){
  return y - x;
});
exports.multiply = exports.times = __curry(function(x, y){
  return x * y;
});
exports.divide = __curry(function(x, y){
  return x / y;
});
exports.divideBy = __curry(function(x, y){
  return y / x;
});
exports.even = function(x){
  return x % 2 === 0;
};
exports.odd = function(x){
  return x % 2 !== 0;
};
exports.gcd = __curry(function(x, y){
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
exports.lcm = __curry(function(x, y){
  return Math.abs(Math.floor(x / gcd(x, y) * y));
});
exports.id = function(x){
  return x;
};
exports.flip = __curry(function(f, x, y){
  return f(y, x);
});
exports.error = function(msg){
  throw msg;
};
exports.each = __curry(function(f, xs){
  var x, __i, __len;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    f(x);
  }
  return xs;
});
exports.map = __curry(function(f, xs){
  var result, x, __i, __len;
  result = [];
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    result.push(f(x));
  }
  return result;
});
exports.cons = __curry(function(x, xs){
  return [(x)].concat(xs);
});
exports.append = __curry(function(xs, ys){
  return (xs).concat(ys);
});
exports.filter = __curry(function(f, xs){
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
exports.reject = __curry(function(f, xs){
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
exports.find = __curry(function(f, xs){
  var x, __i, __len;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    if (f(x)) {
      return x;
    }
  }
});
exports.pluck = __curry(function(prop, xs){
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
exports.head = function(xs){
  return xs.slice(0, 1);
};
exports.tail = function(xs){
  return xs.slice(1);
};
exports.last = function(xs){
  return xs.slice(xs.length - 1);
};
exports.initial = function(xs){
  return xs.slice(0, xs.length - 1);
};
exports.empty = function(xs){
  return !xs.length;
};
exports.length = function(xs){
  return xs.length;
};
exports.reverse = function(xs){
  return xs.slice().reverse();
};
exports.fold = exports.foldl = __curry(function(f, memo, xs){
  var x, __i, __len;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    memo = f(memo, x);
  }
  return memo;
});
exports.fold1 = exports.foldl1 = __curry(function(f, xs){
  return fold(f, xs[0], xs.slice(1));
});
exports.foldr = __curry(function(f, memo, xs){
  return fold(f, memo, xs.reverse());
});
exports.foldr1 = __curry(function(f, xs){
  xs.reverse();
  return fold(f, xs[0], xs.slice(1));
});
exports.andList = function(xs){
  return fold(function(memo, x){
    return memo && x;
  }, true, xs);
};
exports.orList = function(xs){
  return fold(function(memo, x){
    return memo || x;
  }, false, xs);
};
exports.any = __curry(function(f, xs){
  return fold(function(memo, x){
    return memo || f(x);
  }, false, xs);
});
exports.all = __curry(function(f, xs){
  return fold(function(memo, x){
    return memo && f(x);
  }, true, xs);
});
exports.sum = function(xs){
  var result, x, __i, __len;
  result = 0;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    result += x;
  }
  return result;
};
exports.product = function(xs){
  var result, x, __i, __len;
  result = 1;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    result *= x;
  }
  return result;
};
exports.concat = function(xss){
  return fold(append, [], xss);
};
exports.concatMap = __curry(function(f, xs){
  return concat(map(f, xs));
});
exports.maximum = function(xs){
  return Math.max.apply(this, xs);
};
exports.minimum = function(xs){
  return Math.min.apply(this, xs);
};
exports.scan = exports.scanl = __curry(function(f, memo, xs){
  var result, last, x, __i, __len;
  result = [memo];
  last = memo;
  for (__i = 0, __len = xs.length; __i < __len; ++__i) {
    x = xs[__i];
    result.push(last = f(last, x));
  }
  return result;
});
exports.scan1 = exports.scanl1 = __curry(function(f, xs){
  return scan(f, xs[0], xs.slice(1));
});
exports.scanr = __curry(function(f, memo, xs){
  xs.reverse();
  return scan(f, memo, xs).reverse();
});
exports.scanr1 = __curry(function(f, xs){
  xs.reverse();
  return scan(f, xs[0], xs.slice(1)).reverse();
});
exports.replicate = __curry(function(n, x){
  var result, i;
  result = [];
  i = 0;
  for (; i < n; ++i) {
    result.push(x);
  }
  return result;
});
exports.take = __curry(function(n, xs){
  switch (false) {
  case !(n <= 0):
    return xs;
  case !!xs.length:
    return [];
  default:
    return xs.slice(0, n);
  }
});
exports.drop = __curry(function(n, xs){
  switch (false) {
  case !(n <= 0):
    return xs;
  case !!xs.length:
    return [];
  default:
    return xs.slice(n);
  }
});
exports.splitAt = __curry(function(n, xs){
  return [take(n, xs), drop(n, xs)];
});
exports.takeWhile = __curry(function(p, xs){
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
exports.dropWhile = __curry(function(p, xs){
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
exports.span = __curry(function(p, xs){
  return [takeWhile(p, xs), dropWhile(p, xs)];
});
exports.breakList = __curry(function(p, xs){
  return span(__compose((contradict),(p)), xs);
});
exports.elem = __curry(function(x, ys){
  return __in(x, ys);
});
exports.notElem = __curry(function(x, ys){
  return !__in(x, ys);
});
exports.lookup = __curry(function(key, xs){
  return xs != null ? xs[key] : void 8;
});
exports.zip = function(){
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
exports.zipWith = function(f){
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
exports.lines = function(str){
  return str.split('\n');
};
exports.unlines = function(str){
  return str.join('\n');
};
exports.words = function(str){
  return str.split(' ');
};
exports.unwords = function(str){
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