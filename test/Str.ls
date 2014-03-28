{
  id
  Str: {
    split, join, lines, unlines, words, unwords, chars, unchars, empty, reverse
    repeat, capitalize, camelize, dasherize
    slice, take, drop, split-at, take-while, drop-while, span, break-str
  }
} = require '..'
{strict-equal: eq, deep-equal: deep-eq, ok} = require 'assert'

suite 'split' ->
  test 'empty string as input' ->
    deep-eq [], split '' ''

  test 'string of some length' ->
    deep-eq <[ 1 2 3 ]>, split '|' '1|2|3'

  test 'curried' ->
    f = split '|'
    deep-eq <[ 1 2 3 ]>, f '1|2|3'

suite 'join' ->
  test 'empty list as input' ->
    eq '' join '', []

  test 'list as input' ->
    eq '1,2,3', join ',' [1 2 3]

  test 'empty string as seperator' ->
    eq '123', join '' [1 2 3]

  test 'curried' ->
    f = join ','
    eq '1,2,3', f [1 2 3]

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

suite 'empty' ->
  test 'empty string as input' ->
    ok empty ''

  test 'string as input' ->
    ok not empty 'a'

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
    eq 'hihihihihihihihihihi', repeat 10 'hi'

  test 'curried' ->
    f = repeat 2
    eq 'aa', f 'a'


suite 'capitalize' ->
  test 'empty string as input' ->
    eq '', capitalize ''

  test 'basic' ->
    eq 'Foo', capitalize 'foo'

suite 'camelize' ->
  test 'empty string as input' ->
    eq '', camelize ''

  test 'no change' ->
    eq 'fooBar', camelize 'fooBar'

  test 'dashes' ->
    eq 'fooBar', camelize 'foo-bar'

  test 'underscore' ->
    eq 'fooBar', camelize 'foo_bar'

  test 'ending dash' ->
    eq 'fooBar', camelize 'foo-bar-'

  test 'more than one' ->
    eq 'fooBar', camelize 'foo--bar'

suite 'dasherize' ->
  test 'empty string as input' ->
    eq '', dasherize ''

  test 'no change' ->
    eq 'foo-bar', dasherize 'foo-bar'

  test 'basic' ->
    eq 'foo-bar', dasherize 'fooBar'

  test 'with numbers' ->
    eq 'f1-bar', dasherize 'f1Bar'

  test 'repeated capitals' ->
    eq 'set-JSON', dasherize 'setJSON'

  test 'starting with capital' ->
    eq 'foo-bar', dasherize 'FooBar'

  test 'starting with repeated capitals' ->
    eq 'JSON-get', dasherize 'JSONget'

suite 'slice' ->
  test 'zero to zero' ->
    eq '', slice 0 0 'hello'

  test 'empty string as input' ->
    eq '', slice  2 3 ''

  test 'parts' ->
    eq 'll', slice 2 4 'hello'

  test 'curried' ->
    f = slice 2
    eq 'll', f 4 'hello'

    g = slice 2 4
    eq 'll', g 'hello'

suite 'take' ->
  test 'empty string as input' ->
    eq '', take 3 ''

  test 'zero on string' ->
    eq '', take 0 'abcde'

  test 'string' ->
    eq 'ab', take 2 'abcde'

  test 'curried' ->
    f = take 2
    eq 'ab', f 'abcde'

suite 'drop' ->
  test 'empty string as input' ->
    eq '', drop 3 ''

  test 'zero on string' ->
    eq 'abcde', drop 0 'abcde'

  test 'string' ->
    eq 'cde', drop 2 'abcde'

  test 'curried' ->
    f = drop 2
    eq 'cde', f 'abcde'

suite 'split-at' ->
  test 'empty string as input' ->
    deep-eq ['', ''], split-at 3 ''

  test 'zero on string' ->
    deep-eq ['', 'abcde'], split-at 0 'abcde'

  test 'string' ->
    deep-eq ['ab', 'cde'], split-at 2 'abcde'

  test 'curried' ->
    f = split-at 2
    deep-eq ['ab', 'cde'], f 'abcde'

suite 'take-while' ->
  test 'empty string as input' ->
    eq '', take-while id, ''

  test 'string' ->
    eq 'mmmmm', take-while (is 'm'), 'mmmmmhmm'

  test 'curried' ->
    f = take-while (is 'm')
    eq 'mmmmm', f 'mmmmmhmm'

suite 'drop-while' ->
  test 'empty string as input' ->
    eq '', drop-while id, ''

  test 'string' ->
    eq 'hmm', drop-while (is \m), 'mmmmmhmm'

  test 'curried' ->
    f = drop-while (is \m)
    eq 'hmm', f 'mmmmmhmm'

suite 'span' ->
  test 'empty string as input' ->
    deep-eq ['', ''], span id, ''

  test 'string' ->
    deep-eq ['mmmmm', 'hmm'], span (is \m), 'mmmmmhmm'

  test 'curried' ->
    f = span (is \m)
    deep-eq ['mmmmm', 'hmm'], f 'mmmmmhmm'

suite 'break-str' ->
  test 'empty string as input' ->
    deep-eq ['', ''], break-str id, ''

  test 'string' ->
    deep-eq ['mmmmm', 'hmm'], break-str (is \h), 'mmmmmhmm'

  test 'curried' ->
    f = break-str (is \h)
    deep-eq ['mmmmm', 'hmm'], f 'mmmmmhmm'
