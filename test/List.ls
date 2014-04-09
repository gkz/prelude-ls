{
  id
  Num: {even, odd, floor, is-it-NaN}
  List: {
    each, map, filter, compact, reject, partition, find,
    head, first, tail, last, initial, empty,
    reverse, difference, intersection, union, count-by, group-by,
    fold, fold1, foldl, foldl1, foldr, foldr1, unfoldr, and-list, or-list,
    any, all, unique, unique-by, sort, sort-with, sort-by, sum, product, mean, average,
    concat, concat-map, flatten,
    maximum, minimum, maximum-by, minimum-by,
    scan, scan1, scanl, scanl1, scanr, scanr1,
    slice, take, drop, split-at, take-while, drop-while, span, break-list,
    zip, zip-with, zip-all, zip-all-with,
    at, elem-index, elem-indices, find-index, find-indices,
  }
} = require '..'
{strict-equal: eq, deep-equal: deep-eq, ok} = require 'assert'

suite 'each' ->
  test 'empty list as input' ->
    deep-eq [], each id, []

  test 'side effects affect input (and thus result)' ->
    deep-eq [[1],[2]] each (.pop!), [[1 5] [2 6]]

  test 'curried' ->
    f = each (.pop!)
    deep-eq [[1],[2]], f [[1 5] [2 6]]

suite 'map' ->
  test 'empty list as input' ->
    deep-eq [], map id, []

  test 'mapping over array' ->
    deep-eq [2 3 4], map (+ 1), [1 2 3]

  test 'curried' ->
    f = map (+ 1)
    deep-eq [2 3 4], f [1 2 3]

suite 'compact' ->
  test 'empty list as input' ->
    deep-eq [], compact []

  test 'compacting array' ->
    deep-eq [1 true 'ha'], compact [0 1 false true '' 'ha']

suite 'filter' ->
  test 'empty list as input' ->
    deep-eq [], filter id, []

  test 'filtering array' ->
    deep-eq [2, 4], filter even, [1 to 5]

  test 'filter on true returns original list' ->
    deep-eq [1 2 3], filter (-> true), [1 2 3]

  test 'filter on false returns empty list' ->
    deep-eq [], filter (-> false), [1 2 3]

  test 'curried' ->
    f = filter even
    deep-eq [2, 4], f [1 to 5]

suite 'reject' ->
  test 'empty list as input' ->
    deep-eq [], reject id, []

  test 'reject list' ->
    deep-eq [1 3 5], reject even, [1 to 5]

  test 'reject on true returns empty list' ->
    deep-eq [], reject (-> true), [1 2 3]

  test 'reject on true returns original list' ->
    deep-eq [1 2 3], reject (-> false), [1 2 3]

  test 'curried' ->
    f = reject even
    deep-eq [1 3 5], f [1 to 5]

suite 'partition' ->
  test 'empty list as input' ->
    deep-eq [[],[]], partition id, []

  test 'partition list' ->
    deep-eq [[76 88 77 90],[49 58 43]], partition (>60), [49 58 76 43 88 77 90]

  test 'partition on true returns original list as passing, empty list as failing' ->
    deep-eq [[1 2 3],[]], partition (-> true), [1 2 3]

  test 'partition on false returns empty list as failing, empty list as passing' ->
    deep-eq [[], [1 2 3]], partition (-> false), [1 2 3]

  test 'curried' ->
    f = partition (>60)
    deep-eq [[76 88 77 90],[49 58 43]], f [49 58 76 43 88 77 90]

suite 'find' ->
  test 'empty list as input' ->
    eq void, find id, []

  test 'find from list' ->
    eq 4, find even, [3 1 4 8 6]

  test 'finding nothing when function always false' ->
    eq void, find (-> false), [1 2 3]

  test 'find first item when function always true' ->
    eq 1, find (-> true), [1 2 3]

  test 'curried' ->
    f = find even
    eq 4, f [3 1 4 8 6]

suite 'list portions' ->
  list = [1 2 3 4 5]

  suite 'head' ->
    test 'empty list as input' ->
      eq void, head []

    test 'list' ->
      eq 1, head list

    test 'first as alias' ->
      eq first, head

  suite 'tail' ->
    test 'empty list as input' ->
      eq void, tail []

    test 'list' ->
      deep-eq [2 3 4 5], tail list

    test 'one element list' ->
      deep-eq [], tail [1]

  suite 'last' ->
    test 'empty list as input' ->
      eq void, last []

    test 'list' ->
      eq 5, last list

    test 'one element list' ->
      eq 1, last [1]

  suite 'initial' ->
    test 'empty list as input' ->
      eq void, initial []

    test 'list' ->
      deep-eq [1 2 3 4], initial list

    test 'one element list' ->
      deep-eq [], initial [1]

suite 'empty' ->
  test 'empty list as input' ->
    ok empty []

  test 'non-empty list as input' ->
    ok not empty [1]

suite 'reverse' ->
  test 'empty list as input' ->
    deep-eq [], reverse []

  test 'reverse list, it is unmodified' ->
    list = [1 2 3 4 5]
    deep-eq [5 4 3 2 1], reverse list
    deep-eq [1 2 3 4 5], list

suite 'unique' ->
  test 'empty list as input' ->
    deep-eq [], unique []

  test 'unique list' ->
    deep-eq [1,2,3,4,5,6], unique [1 1 2 3 3 4 5 5 5 5 5 6 6 6 6]

  test 'mixed string/num' ->
    deep-eq ['1' 1 2 4 5], unique ['1' 1 2 4 5 5]

suite 'unique-by' ->
  test 'empty list as input' ->
    deep-eq [], unique-by id, []

  test 'basic' ->
    deep-eq [1,2,3,4,5,6], unique-by id, [1 1 2 3 3 4 5 5 5 5 5 6 6 6 6]

  test 'accessor' ->
    deep-eq [[] [1 2 3] [4] [5 6]], unique-by (.length), [[], [1 2 3], [4], [5 6], [7], [8 9 10]]

  test 'curried' ->
    deep-eq [1,2,3,4,5,6], (unique-by id) [1 1 2 3 3 4 5 5 5 5 5 6 6 6 6]

suite 'fold' ->
  test 'empty list as input' ->
    eq 0, fold (+), 0, []

  test 'list as input' ->
    eq 12, fold (+), 0, [1 2 3 6]

  test 'foldl is alias' ->
    eq fold, foldl

  test 'curried' ->
    f = fold (+)
    eq 12, f 0, [1 2 3 6]

    g = fold (+), 0
    eq 12 g [1 2 3 6]

suite 'fold1' ->
  test 'empty list as input' ->
    eq void, fold1 (+), []

  test 'list as input' ->
    eq 12, fold1 (+), [1 2 3 6]

  test 'foldl1 as alais' ->
    eq fold1, foldl1

  test 'curried' ->
    f = fold1 (+)
    eq 12, f [1 2 3 6]

suite 'foldr' ->
  test 'empty list as input' ->
    eq 0, foldr (+), 0, []

  test 'list as input' ->
    eq 7, foldr (-), 9, [1 2 3 4]
    eq 'abcde', foldr (+), 'e', <[ a b c d ]>

  test 'curried' ->
    f = foldr (-)
    eq 7, f 9, [1 2 3 4]

    g = foldr (-), 9
    eq 7, g [1 2 3 4]

suite 'foldr1' ->
  test 'empty list as input' ->
    eq void, foldr1 (+), []

  test 'list as input' ->
    eq 7, foldr1 (-), [1 2 3 4 9]
    eq 'abcde', foldr1 (+), <[ a b c d e ]>

  test 'curried' ->
    f = foldr1 (-)
    eq 7, f [1 2 3 4 9]

suite 'unfoldr' ->
  test 'complex case' ->
    deep-eq [10,9,8,7,6,5,4,3,2,1], unfoldr (-> if it == 0 then null else [it, it - 1]), 10

  test 'returning null right away results in a one item list' ->
    deep-eq [], unfoldr (-> null), 'a'

  test 'curried' ->
    f = unfoldr (-> if it == 0 then null else [it, it - 1])
    deep-eq [10,9,8,7,6,5,4,3,2,1], f 10

suite 'concat' ->
  test 'empty list as input' ->
    deep-eq [], concat []

  test 'multiple lists' ->
    deep-eq [1,2,3,4,5,6], concat [[1 2] [3 4] [5 6]]

suite 'concat-map' ->
  test 'empty list as input' ->
    deep-eq [], concat-map id, []

  test 'using mapping and concatinating' ->
    deep-eq [1,1,2,1,2,3], concat-map (-> [1 to it]), [1 2 3]

  test 'curried' ->
    f = concat-map (-> [1 to it])
    deep-eq [1,1,2,1,2,3], f [1 2 3]

suite 'flatten' ->
  test 'empty list as input' ->
    deep-eq [], flatten []

  test 'nested lists as input' ->
    deep-eq [1,2,3,4,5], flatten [1, [[2], 3], [4, [[5]]]]

  test 'lists with strings' ->
    deep-eq ['a','b','c','d','e'], flatten ['a', [['b'], 'c'], ['d', [['e']]]]

suite 'difference' ->
  test 'empty list(s) as input' ->
    deep-eq [], difference []
    deep-eq [], difference [] []

  test 'subtract nothing' ->
    deep-eq [1 2 3], difference [1 2 3]
    deep-eq [1 2 3], difference [1 2 3] []

  test 'subtract single element' ->
    deep-eq [2 3], difference [1 2 3] [1]

  test 'subtract multiple elements' ->
    deep-eq [1 3 4], difference [1 2 3 4 5] [5 2 10] [9]

suite 'intersection' ->
  test 'empty list(s) as input' ->
    deep-eq [], intersection []
    deep-eq [], intersection [] []

  test 'no common elements' ->
    deep-eq [],intersection [2 3] [9 8] [12 1] [99]

  test 'some common elements' ->
    deep-eq [1 2], intersection [1 2 3] [101 2 1 10] [2 1] [-1 0 1 2]

  test 'all common elements' ->
    deep-eq [1 2 3], intersection [1 2 3] [2 1 3] [3 1 2]

suite 'union' ->
  test 'empty list(s) as input' ->
    deep-eq [], union []
    deep-eq [], union [] []

  test 'list and empty list' ->
    deep-eq [1 2 3], union [1 2 3] []

  test 'with various' ->
    deep-eq [1 5 7 3], union [1 5 7] [3 5] []

suite 'count-by' ->
  test 'empty list as input' ->
    deep-eq [], count-by id, []

  test 'list of numbers' ->
    deep-eq {4: 1, 6: 2}, count-by floor, [4.2, 6.1, 6.4]

  test 'list of strings' ->
    deep-eq {3: 2, 5: 1}, count-by (.length), <[ one two three ]>

  test 'curried' ->
    f = count-by floor
    deep-eq {4: 1, 6: 2}, f [4.2, 6.1, 6.4]

suite 'group-by' ->
  test 'empty list as input' ->
    deep-eq [], group-by id, []

  test 'list of numbers' ->
    deep-eq {4: [4.2], 6: [6.1 6.4]}, group-by floor, [4.2, 6.1, 6.4]

  test 'list of strings' ->
    deep-eq {3: <[ one two ]>, 5: <[ three ]>}, group-by (.length), <[ one two three ]>

  test 'curried' ->
    f = group-by floor
    deep-eq {4: [4.2], 6: [6.1 6.4]}, f [4.2, 6.1, 6.4]

suite 'and-list' ->
  test 'empty list as input' ->
    ok and-list []

  test 'true' ->
    ok and-list [true, 2 + 2 == 4]

  test 'false' ->
    ok not and-list [true true false true]

suite 'or-list' ->
  test 'empty list as input' ->
    ok not or-list []

  test 'true' ->
    ok or-list [false false false true false]

  test 'false' ->
    ok not or-list [false, 2 + 2 == 3]

suite 'any' ->
  test 'empty list as input' ->
    ok not any id, []

  test 'true' ->
    ok any even, [1 4 3]

  test 'false' ->
    ok not any even, [1 3 7 5]

  test 'curried' ->
    f = any even
    ok f [1 4 3]

suite 'all' ->
  test 'empty list as input' ->
    ok all even, []

  test 'true' ->
    ok all even, [2 4 6]

  test 'false' ->
    ok not all even, [2 5 6]

  test 'curried' ->
    f = all even
    ok f [2 4 6]

suite 'sort' ->
  test 'empty list as input' ->
    deep-eq [], sort []

  test 'single digit numbers' ->
    deep-eq [1,2,3,4,5,6], sort [3 1 5 2 4 6]

  test 'multi digit numbers' ->
    deep-eq [2,5,6,12,334,4999], sort [334 12 5 2 4999 6]

  test 'same digits' ->
    deep-eq [1 2 2 2 3], sort [2 3 2 1 2]

suite 'sort-with' ->
  f = (x, y) ->
    | x.length > y.length => 1
    | x.length < y.length => -1
    | otherwise           => 0

  test 'empty list as input' ->
    deep-eq [], sort-with id, []

  test 'complex case' ->
    deep-eq ['one','two','three'], sort-with f, <[ three one two ]>

  test 'curried' ->
    g = sort-with f
    deep-eq ['one','two','three'], g <[ three one two ]>

suite 'sort-by' ->
  arr =
    'hey'
    'a'
    'there'
    'hey'
    'ha'

  test 'empty list as input' ->
    deep-eq [], sort-by id, []

  test 'complex case' ->
    deep-eq ['a', 'ha', 'hey', 'hey', 'there'], sort-by (.length), arr

  test 'curried' ->
    f = sort-by (.length)
    deep-eq ['a', 'ha', 'hey', 'hey', 'there'], f arr

suite 'sum' ->
  test 'empty list as input' ->
    eq 0, sum []

  test 'list as input' ->
    eq 10, sum [1 2 3 4]

  test 'negative numbers' ->
    eq -2, sum [1 -2 3 -4]

suite 'product' ->
  test 'empty list as input' ->
    eq 1, product []

  test 'list as input' ->
    eq 24, product [1 2 3 4]

  test 'negative numbers' ->
    eq -6, product [1 -2 3]

suite 'mean' ->
  test 'empty list as input' ->
    ok is-it-NaN mean []

  test 'list as input' ->
    eq 4, mean [2 3 4 5 6]

  test 'average as alias' ->
    eq mean, average

suite 'maximum' ->
  test 'empty list as input' ->
    eq void, maximum []

  test 'single element list' ->
    eq 1, maximum [1]

  test 'multi element list' ->
    eq 6, maximum [1 2 6 4 5]

suite 'minimum' ->
  test 'empty list as input' ->
    eq void, minimum []

  test 'single element list' ->
    eq 1, minimum [1]

  test 'multi element list' ->
    eq 2, minimum [4 3 2 6 9]

  test 'list of strings' ->
    eq 'a', minimum ['c', 'e', 'a', 'd', 'b']

suite 'maximum-by' ->
  test 'empty list as input' ->
    eq void, maximum-by id, []

  test 'single element list' ->
    eq 1, maximum-by id, [1]

  test 'multi element list' ->
    eq 'long-string', maximum-by (.length), <[ hi there I am a really long-string ]>

  test 'curried' ->
    eq 2, (maximum-by id) [1 2 0]

suite 'minimum-by' ->
  test 'empty list as input' ->
    eq void, minimum-by id, []

  test 'single element list' ->
    eq 1, minimum-by id, [1]

  test 'multi element list' ->
    eq 'I', minimum-by (.length), <[ hi there I am a really long-string ]>

  test 'curried' ->
    eq 0, (minimum-by id) [1 2 0]

suite 'scan' ->
  test 'empty list as input' ->
    deep-eq [null], scan id, null, []

  test 'complex case' ->
    deep-eq [4,9,20,43], scan ((x, y) -> 2 * x + y), 4, [1 2 3]

  test 'scanl as alias' ->
    eq scan, scanl

  test 'curried' ->
    f = scan ((x, y) -> 2 * x + y)
    deep-eq [4,9,20,43], f 4, [1 2 3]

    g = scan ((x, y) -> 2 * x + y), 4
    deep-eq [4,9,20,43], g [1 2 3]

suite 'scan1' ->
  test 'empty list as input' ->
    deep-eq void, scan1 id, []

  test 'complex case' ->
    deep-eq [1,3,6,10], scan1 (+), [1 2 3 4]

  test 'scanl1 as alias' ->
    eq scan1, scanl1

  test 'curried' ->
    f = scan1 (+)
    deep-eq [1,3,6,10], f [1 2 3 4]

suite 'scanr' ->
  test 'empty list as input' ->
    deep-eq [null], scanr id, null, []

  test 'complex case' ->
    deep-eq [15,14,12,9,5], scanr (+), 5, [1 2 3 4]

  test 'curried' ->
    f = scanr (+)
    deep-eq [15,14,12,9,5], f 5, [1 2 3 4]

    g = scanr (+), 5
    deep-eq [15,14,12,9,5], g [1 2 3 4]

suite 'scanr1' ->
  test 'empty list as input' ->
    deep-eq void, scanr1 id, []

  test 'complex case' ->
    deep-eq [10,9,7,4], scanr1 (+), [1 2 3 4]

  test 'curried' ->
    f = scanr1 (+)
    deep-eq [10,9,7,4], f [1 2 3 4]

suite 'slice' ->
  test 'zero to zero' ->
    deep-eq [], slice 0 0 [1 2 3 4 5]

  test 'empty lsit as input' ->
    deep-eq [], slice  2 3 []

  test 'parts' ->
    deep-eq [3 4], slice 2 4 [1 2 3 4 5]

  test 'curried' ->
    f = slice 2
    deep-eq [3 4], f 4 [1 2 3 4 5]

    g = slice 2 4
    deep-eq [3 4], g [1 2 3 4 5]

suite 'take' ->
  test 'empty list as input' ->
    deep-eq [], take 3 []

  test 'zero on list' ->
    deep-eq [], take 0 [1 2 3 4 5]

  test 'negative number' ->
    deep-eq [], take -1 [1 2 3 4 5]

  test 'too big number' ->
    deep-eq [1 2 3 4 5], take 9 [1 2 3 4 5]

  test 'list' ->
    deep-eq [1 2 3], take 3 [1 2 3 4 5]

  test 'curried' ->
    f = take 3
    deep-eq [1 2 3], f [1 2 3 4 5]

suite 'drop' ->
  test 'empty list as input' ->
    deep-eq [], drop 3 []

  test 'zero on list' ->
    deep-eq [1 2 3 4 5], drop 0 [1 2 3 4 5]

  test 'negative number' ->
    deep-eq [1 2 3 4 5], drop -1 [1 2 3 4 5]

  test 'too big number' ->
    deep-eq [], drop 9 [1 2 3 4 5]

  test 'list' ->
    deep-eq [4 5], drop 3 [1 2 3 4 5]

  test 'curried' ->
    f = drop 3
    deep-eq [4 5], f [1 2 3 4 5]

suite 'split-at' ->
  test 'empty list as input' ->
    deep-eq [[], []], split-at 3 []

  test 'zero on list' ->
    deep-eq [[], [1 2 3 4 5]], split-at 0 [1 2 3 4 5]

  test 'negative number' ->
    deep-eq [[], [1 2 3 4 5]], split-at -1 [1 2 3 4 5]

  test 'too big number' ->
    deep-eq [[1 2 3 4 5], []], split-at 9 [1 2 3 4 5]

  test 'list' ->
    deep-eq [[1 2 3], [4 5]], split-at 3 [1 2 3 4 5]

  test 'curried' ->
    f = split-at 3
    deep-eq [[1 2 3], [4 5]], f [1 2 3 4 5]

suite 'take-while' ->
  test 'empty list as input' ->
    deep-eq [], take-while id, []

  test 'list' ->
    deep-eq [1 3 5], take-while odd, [1 3 5 4 8 7 9]

  test 'all pass' ->
    deep-eq [42], take-while (== 42), [42]
    deep-eq [2 4 8], take-while even, [2 4 8]

  test 'all fail' ->
    deep-eq [], take-while (== 7), [42]
    deep-eq [], take-while odd, [2 4 8]

  test 'curried' ->
    f = take-while odd
    deep-eq [1 3 5], f [1 3 5 4 8 7 9]

suite 'drop-while' ->
  test 'empty list as input' ->
    deep-eq [], drop-while id, []

  test 'list' ->
    deep-eq [7 9 10], drop-while even, [2 4 6 7 9 10]

  test 'all pass' ->
    deep-eq [], drop-while (== 42), [42]
    deep-eq [], drop-while even, [2 4 8]

  test 'all-fail' ->
    deep-eq [42], drop-while (== 7), [42]
    deep-eq [2 4 8], drop-while odd, [2 4 8]

  test 'curried' ->
    f = drop-while even
    deep-eq [7 9 10], f [2 4 6 7 9 10]

suite 'span' ->
  test 'empty list as input' ->
    deep-eq [[], []], span id, []

  test 'list' ->
    deep-eq [[2 4 6], [7 9 10]], span even, [2 4 6 7 9 10]

  test 'curried' ->
    f = span even
    deep-eq [[2 4 6], [7 9 10]], f [2 4 6 7 9 10]

suite 'break-list' ->
  test 'empty list as input' ->
    deep-eq [[], []], break-list id, []

  test 'list' ->
    deep-eq [[1 2], [3 4 5]], break-list (== 3), [1 2 3 4 5]

  test 'curried' ->
    f = break-list (== 3)
    deep-eq [[1 2], [3 4 5]], f [1 2 3 4 5]

suite 'zip' ->
  test 'empty lists as input' ->
    deep-eq [], zip [] []

  test 'equal length lists' ->
    deep-eq [[1 4], [2 5]], zip [1 2] [4 5]

  test 'first list shorter' ->
    deep-eq [[1 4], [2 5]], zip [1 2] [4 5 6]

  test 'second list shorter' ->
    deep-eq [[1 4], [2 5]], zip [1 2 3] [4 5]

  test 'curried' ->
    f = zip [1 2]
    deep-eq [[1 4], [2 5]], f [4 5]

suite 'zip-with' ->
  test 'empty lists as input' ->
    deep-eq [], zip-with id, [], []

  test 'equal length lists' ->
    deep-eq [4 4 4], zip-with (+), [1 2 3], [3 2 1]

  test 'first list shorter' ->
    deep-eq [5 7], zip-with (+), [1 2], [4 5 6]

  test 'second list shorter' ->
    deep-eq [5 7], zip-with (+), [1 2 3] [4 5]

  test 'curried' ->
    f = zip-with (+)
    deep-eq [4 4 4], f [1 2 3], [3 2 1]

    g = zip-with (+), [1 2 3]
    deep-eq [4 4 4], g [3 2 1]

suite 'zip-all' ->
  test 'empty lists as input' ->
    deep-eq [], zip-all [] [] []

  test 'equal length lists' ->
    deep-eq [[1 4 7], [2 5 8], [3 6 9]], zip-all [1 2 3] [4 5 6] [7 8 9]

  test 'first list shorter' ->
    deep-eq [[1 4 7], [2 5 8]], zip-all [1 2] [4 5 6] [7 8 9]

  test 'second list shorter' ->
    deep-eq [[1 4 7], [2 5 8]], zip-all [1 2 3] [4 5] [7 8 9]

  test 'third list shorter' ->
    deep-eq [[1 4 7], [2 5 8]], zip-all [1 2 3] [4 5 6] [7 8]

suite 'zip-all-with' ->
  test 'empty lists as input' ->
    deep-eq [], zip-all-with id, [], []

  test 'equal length lists' ->
    deep-eq [5 5 5], zip-all-with (-> &0 + &1 + &2), [1 2 3], [3 2 1], [1 1 1]

  test 'first list shorter' ->
    deep-eq [5 7], zip-all-with (+), [1 2], [4 5 6]

  test 'second list shorter' ->
    deep-eq [5 7], zip-all-with (+), [1 2 3] [4 5]

suite 'at' ->
  test 'empty list as input' ->
    eq void, at 0, []

  test 'positive n' ->
    eq 2, at 1, [1 2 3]

  test 'negative n' ->
    eq 3, at -1, [1 2 3]

  test 'not defined at index' ->
    eq void, at 10, [1 2 3]

  test 'curried' ->
    eq 2, (at 1) [1 2 3]

suite 'elem-index' ->
  test 'empty list as input' ->
    eq void, elem-index 2, []

  test 'basic' ->
    eq 1, elem-index 2, [1 2 3]

  test 'multiple' ->
    eq 1, elem-index 2, [1 2 3 2 1]

  test 'not there' ->
    eq void, elem-index 5, [1 2 3]

  test 'curried' ->
    eq 1, (elem-index 2) [1 2 3]

suite 'elem-indices' ->
  test 'empty list as input' ->
    deep-eq [], elem-indices 2, []

  test 'single' ->
    deep-eq [1], elem-indices 2, [1 2 3]

  test 'multiple' ->
    deep-eq [1, 3], elem-indices 2, [1 2 3 2 1]

  test 'not there' ->
    deep-eq [], elem-indices 5, [1 2 3]

  test 'curried' ->
    deep-eq [1], (elem-indices 2) [1 2 3]

suite 'find-index' ->
  test 'empty list as input' ->
    eq void, find-index id, []

  test 'basic' ->
    eq 1, find-index (== 2), [1 2 3]

  test 'multiple' ->
    eq 1, find-index even, [1 2 3 4]

  test 'not there' ->
    eq void, find-index odd, [2 4 6]

  test 'curried' ->
    eq 1, (find-index (== 2)) [1 2 3]

suite 'find-indices' ->
  test 'empty list as input' ->
    deep-eq [], find-indices id, []

  test 'basic' ->
    deep-eq [1], find-indices (== 2), [1 2 3]

  test 'multiple' ->
    deep-eq [1, 3], find-indices even, [1 2 3 4]

  test 'not there' ->
    deep-eq [], find-indices odd, [2 4 6]

  test 'curried' ->
    deep-eq [1], (find-indices (== 2)) [1 2 3]
