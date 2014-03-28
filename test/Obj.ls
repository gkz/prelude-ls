{
  id
  Obj: {
    values, keys,
    pairs-to-obj, obj-to-pairs, lists-to-obj, obj-to-lists,
    empty, each, map, filter, compact, reject, partition, find,
  }
} = require '..'
{strict-equal: eq, deep-equal: deep-eq, ok} = require 'assert'

suite 'values' ->
  test 'empty object as input' ->
    deep-eq [], values {}

  test 'object as input' ->
    deep-eq [1 2 3], values sadf: 1, asdf: 2, fdas: 3

suite 'keys' ->
  test 'empty object as input' ->
    deep-eq [], keys {}

  test 'object as input' ->
    deep-eq <[ sadf asdf fdas ]>, keys sadf: 1, asdf: 2, fdas: 3

suite 'pairs-to-obj' ->
  test 'empty list as input' ->
    deep-eq {}, pairs-to-obj []

  test 'pairs as input' ->
    deep-eq {a: 'b', c: 'd', e: 1}, pairs-to-obj [['a' 'b'] ['c' 'd'] ['e' 1]]

suite 'obj-to-pairs' ->
  test 'empty object as input' ->
    deep-eq [], obj-to-pairs {}

  test 'object as input' ->
    deep-eq [['a' 'b'] ['c' 'd'] ['e' 1]], obj-to-pairs {a: 'b', c: 'd', e: 1}

suite 'lists-to-obj' ->
  test 'empty lists as input' ->
    deep-eq {}, lists-to-obj [] []

  test 'two lists of the same length' ->
    deep-eq  {a: 1, b: 2, c: 3}, lists-to-obj <[ a b c ]> [1 2 3]

  test 'first list is shorter' ->
    deep-eq  {a: 1, b: 2}, lists-to-obj <[ a b ]> [1 2 3]

  test 'first list is longer' ->
    deep-eq  {a: 1, b: 2, c: void}, lists-to-obj <[ a b c ]> [1 2]

  test 'curried' ->
    f = lists-to-obj <[ a b c ]>
    deep-eq  {a: 1, b: 2, c: 3}, f [1 2 3]

suite 'obj-to-lists' ->
  test 'empty object as input' ->
    deep-eq [[], []], obj-to-lists {}

  test 'two lists of the same length' ->
    deep-eq [<[ a b c ]>, [1 2 3]], obj-to-lists {a: 1, b: 2, c: 3}

suite 'empty' ->
  test 'empty object as input' ->
    ok empty {}

  test 'non-empty object as input' ->
    ok not empty {x: 1}

suite 'each' ->
  test 'empty object as input' ->
    deep-eq {}, each id, {}

  test 'iterate over object values' ->
    count = 4
    each (-> count += it), {a: 1, b: 2, c: 3}
    eq 10 count

  test 'curried' ->
    count = 4
    f = each (-> count += it)
    f {a: 1, b: 2, c: 3}
    eq 10 count

suite 'map' ->
  test 'empty object as input' ->
    deep-eq {}, map id, {}

  test 'mapping over object' ->
    deep-eq {a:2, b:4}, map (* 2), {a:1, b:2}

  test 'curried' ->
    f = map (* 2)
    deep-eq {a:2, b:4}, f {a:1, b:2}

suite 'compact' ->
  test 'empty object as input' ->
    deep-eq {}, compact {}

  test 'compacting object' ->
    deep-eq {b: 1, e: 'ha'}, compact {a: 0, b: 1, c: false, d: '', e: 'ha'}

suite 'filter' ->
  test 'empty object as input' ->
    deep-eq {}, filter id, {}

  test 'filtering object' ->
    deep-eq {b: 2}, filter (== 2), {a:1, b:2}

  test 'curried' ->
    f = filter (== 2)
    deep-eq {b: 2}, f {a:1, b:2}

suite 'reject' ->
  test 'empty object as input' ->
    deep-eq {}, reject id, {}

  test 'reject object' ->
    deep-eq {a: 1}, reject (==2), {a:1, b:2}

  test 'curried' ->
    f = reject (== 2)
    deep-eq {a: 1}, f {a:1, b:2}

suite 'partition' ->
  test 'empty object as input' ->
    deep-eq [{}, {}], partition id, {}

  test 'partition object' ->
    deep-eq [{b: 2}, {a: 1, c: 3}], partition (==2), {a:1, b:2, c:3}

  test 'curried' ->
    f = partition (== 2)
    deep-eq [{b: 2}, {a: 1, c: 3}], f {a:1, b:2, c:3}

suite 'find' ->
  test 'empty object as input' ->
    eq void, find id, {}

  test 'find from object' ->
    eq 2, find (==2), {a:1, b:2}

  test 'curried' ->
    f = find (== 2)
    eq 2, f {a:1, b:2}
