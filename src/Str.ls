split = (sep, str) -->
  str.split sep

join = (sep, xs) -->
  xs.join sep

lines = (str) ->
  return [] unless str.length
  str.split '\n'

unlines = (.join '\n')

words = (str) ->
  return [] unless str.length
  str.split /[ ]+/

unwords = (.join ' ')

chars = (.split '')

unchars = (.join '')

reverse = (str) ->
  str.split '' .reverse!.join ''

repeat = (n, str) -->
  out = [str for til n]
  out.join ''

module.exports = {
  split, join, lines, unlines, words, unwords, chars, unchars, reverse, repeat,
}
