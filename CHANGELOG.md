# 0.6.0
* fixed various bugs
* added `fix`, a fixpoint (Y combinator) for anonymous recursive functions
* added `unfoldr` (alias `unfold`)
* calling `replicate` with a string now returns a list of strings
* removed `partial`, just use native partial application in LiveScript using the `_` placeholder, or currying
* added `sort`, `sortBy`, and `compare`

# 0.5.0
* removed `lookup` - use (.prop)
* removed `call` - use (.func arg1, arg2)
* removed `pluck` - use map (.prop), xs
* fixed buys wtih `head` and `last`
* added non-minifed browser version, as `prelude-browser.js`
* renamed `prelude-min.js` to `prelude-browser-min.js`
* renamed `zip` to `zipAll`
* renamed `zipWith` to `zipAllWith`
* added `zip`, a curried zip that takes only two arguments
* added `zipWith`, a curried zipWith that takes only two arguments

# 0.4.0
* added `parition` function
* added `curry` function
* removed `elem` function (use `in`)
* removed `notElem` function (use `not in`)

# 0.3.0
* added `listToObject`
* added `unique`
* added `objToFunc`
* added support for using strings in map and the like
* added support for using objects in map and the like
* added ability to use objects instead of functions in certain cases
* removed `error` (just use throw)
* added `tau` constant
* added `join`
* added `values`
* added `keys`
* added `partial`
* renamed `log` to `ln`
* added alias to `head`: `first`
* added `installPrelude` helper

# 0.2.0
* removed functions that simply warp operators as you can now use operators as functions in LiveScript
* `min/max` are now curried and take only 2 arguments
* added `call`

# 0.1.0
* initial public release
