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
  result = ''
  for til n
    result += str
  result

capitalize = (str) ->
  (str.char-at 0).to-upper-case! + str.slice 1

camelize = (.replace /[-_]+(.)?/g, (, c) -> (c ? '').to-upper-case!)

# convert camelCase to camel-case, and setJSON to set-JSON
dasherize = (str) ->
    str
      .replace /([^-A-Z])([A-Z]+)/g, (, lower, upper) ->
         "#{lower}-#{if upper.length > 1 then upper else upper.to-lower-case!}"
      .replace /^([A-Z]+)/, (, upper) ->
         if upper.length > 1 then "#upper-" else upper.to-lower-case!

module.exports = {
  split, join, lines, unlines, words, unwords, chars, unchars, reverse,
  repeat, capitalize, camelize, dasherize,
}
