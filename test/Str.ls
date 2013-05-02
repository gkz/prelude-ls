Prelude = require '../lib/Prelude.js'
{id} = Prelude
{
  split, join, lines, unlines, words, unwords, chars, unchars, reverse, repeat,
  slice, take, drop, split-at, take-while, drop-while, span, break-str
} = Prelude.Str
require! assert
{equal: eq, deep-equal: deep-eq, ok} = assert

suite 'split' ->
  test 'empty string as input' ->
    deep-eq [], split '' ''

  test 'string of some length' ->
    deep-eq <[ 1 2 3 ]>, split '|' '1|2|3'

suite 'join' ->
  test 'empty list as input' ->
    eq '' join '', []

  test 'list as input' ->
    eq '1,2,3', join ',' [1 2 3]

  test 'empty string as seperator' ->
    eq '123', join '' [1 2 3]

suite 'lines' ->
  test 'empty string as input' ->
    deep-eq [], lines ''

  test 'string as input' ->
    deep-eq <[ one two three ]>, lines 'one\ntwo\nthree'

suite 'unlines' ->
  test 'empty array as input' ->
    eq '', unlines []

  test 'array as input' ->
    eq 'one\ntwo\nthree', unlines [\one \two \three]

suite 'words' ->
  test 'empty string as input' ->
    deep-eq [], words ''

  test 'string as input' ->
    deep-eq <[ what is this ]>, words 'what   is  this'

suite 'unwords' ->
  test 'empty array as input' ->
    eq '', unwords []

  test 'array as input' ->
    eq 'what is this', unwords [\what \is \this]

suite 'chars' ->
  test 'empty string as input' ->
    deep-eq [], chars ''

  test 'string as input' ->
    deep-eq <[ h e l l o ]>, chars 'hello'

suite 'unchars' ->
  test 'empty array as input' ->
    eq '', unchars []

  test 'array as input' ->
    eq 'there', unchars ['t', 'h', 'e', 'r', 'e']

suite 'reverse' ->
  test 'empty string as input' ->
    eq '', reverse ''

  test 'a string' ->
    eq 'cba', reverse 'abc'
    eq 'olleh', reverse 'hello'

suite 'repeat' ->
  test 'zero times' ->
    eq '' repeat 0 'hi'

  test 'empty string as input' ->
    eq '', repeat 2 ''

  test 'a string several times' ->
    eq 'aa', repeat 2 'a'
    eq 'hihihi', repeat 3 'hi'

suite 'slice' ->
  test 'zero to zero' ->
    eq '', slice 0 0 'hello'

  test 'empty string as input' ->
    eq '', slice  2 3 ''

  test 'parts' ->
    eq 'll', slice 2 4 'hello'

suite 'take' ->
  test 'empty string as input' ->
    eq '', take 3 ''

  test 'zero on string' ->
    eq '', take 0 'abcde'

  test 'string' ->
    eq 'ab', take 2 'abcde'

suite 'drop' ->
  test 'empty string as input' ->
    eq '', drop 3 ''

  test 'zero on string' ->
    eq 'abcde', drop 0 'abcde'

  test 'string' ->
    eq 'cde', drop 2 'abcde'

suite 'split-at' ->
  test 'empty string as input' ->
    deep-eq ['', ''], split-at 3 ''

  test 'zero on string' ->
    deep-eq ['', 'abcde'], split-at 0 'abcde'

  test 'string' ->
    deep-eq ['ab', 'cde'], split-at 2 'abcde'

suite 'take-while' ->
  test 'empty string as input' ->
    eq '', take-while id, ''

  test 'string' ->
    eq 'mmmmm', take-while (is 'm'), 'mmmmmhmm'

suite 'drop-while' ->
  test 'empty string as input' ->
    eq '', drop-while id, ''
  test 'string' ->
    eq 'hmm', drop-while (is \m), 'mmmmmhmm'

suite 'span' ->
  test 'empty string as input' ->
    deep-eq ['', ''], span id, ''
  test 'string' ->
    deep-eq ['mmmmm', 'hmm'] span (is \m), 'mmmmmhmm'

suite 'break-str' ->
  test 'empty string as input' ->
    deep-eq ['', ''], break-str id, ''

  test 'string' ->
    deep-eq ['mmmmm', 'hmm'] break-str (is \h), 'mmmmmhmm'
