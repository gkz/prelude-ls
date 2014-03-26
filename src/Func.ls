apply = (f, list) -->
  f.apply null, list

curry = (f) ->
  curry$ f # using util method curry$ from livescript

flip = (f, x, y) --> f y, x

fix = (f) ->
  ( (g) -> -> f(g g) ...arguments ) do
    (g) -> -> f(g g) ...arguments

over = (f, g, x, y) --> f (g x), (g y)

#? memoize, wrap

module.exports = {
  curry, flip, fix, apply, over,
}
