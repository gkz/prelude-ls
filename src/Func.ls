curry = (f) ->
  curry$ f # using util method curry$ from livescript

flip = (f, x, y) --> f y, x

fix = (f) ->
  ( (g, x) -> -> f(g g) ...arguments ) do
    (g, x) -> -> f(g g) ...arguments

apply = (f, list) -->
  f.apply null, list

#? memoize, wrap

module.exports = {
  curry, flip, fix, apply
}
