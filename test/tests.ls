global <<< require \../prelude.js
require! assert
{equal: eq, deep-equal: deep-eq, ok} = assert

suite 'id' ->
  test 'number' ->
    eq 5, id 5

  test 'object is the same' ->
    obj = {}
    eq obj, id obj

suite 'obj-to-func' ->
  test 'empty object as input' ->
    f = obj-to-func {}
    eq void, f 'ha'

  test 'object to function' ->
    f = obj-to-func one: 1, two: 2
    eq 2, f 'two'

  test 'list to function' ->
    f = obj-to-func [1 2]
    eq 2, f '1'

suite 'list-to-obj' ->
  test 'empty list as input' ->
    deep-eq {}, list-to-obj []

  test 'list as object' ->
    deep-eq {a: 'b', c: 'd', e: 1}, list-to-obj [['a' 'b'] ['c' 'd'] ['e' 1]]

suite 'lists-to-obj' ->
  test 'empty lists as input' ->
    deep-eq {}, lists-to-obj [] []

  test 'two lists of the same length' ->
    deep-eq  {a: 1, b: 2, c: 3}, lists-to-obj <[ a b c ]> [1 2 3]

  test 'first list is shorter' ->
    deep-eq  {a: 1, b: 2}, lists-to-obj <[ a b ]> [1 2 3]

  test 'first list is longer' ->
    deep-eq  {a: 1, b: 2, c: void}, lists-to-obj <[ a b c ]> [1 2]

suite 'each' ->
  test 'empty list as input' ->
    deep-eq [], each id, []

  test 'empty object as input' ->
    deep-eq {}, each id, {}

  test 'empty string as input' ->
    eq '', each id, ''

  test 'returns input, iterate over string' ->
    test-target = 0
    eq 'hello' each (-> ++test-target), 'hello'
    eq 5 test-target

  test 'side effects affect input (and thus result)' ->
    deep-eq [[1],[2]] each (.pop!), [[1 5] [2 6]]

  test 'iterate over object values' ->
    count = 4
    each (-> count += it), {a: 1, b: 2, c: 3}
    eq 10 count

suite 'map' ->
  test 'empty list as input' ->
    deep-eq [], map id, []

  test 'empty object as input' ->
    deep-eq {}, map id, {}

  test 'empty string as input' ->
    eq '', map id, ''

  test 'mapping over array' ->
    deep-eq [2 3 4], map (+ 1), [1 2 3]

  test 'mapping over object' ->
    deep-eq {a:2, b:4}, map (* 2), {a:1, b:2}

  test 'mapping over string' ->
    eq 'ABC', map (.to-upper-case!), 'abc'

  test 'using object as function' ->
    deep-eq [1, 2, 3, 4], map {one: 1, two: 2, three: 3, four: 4}, <[ one two three four ]>

  test 'using array as function' ->
    deep-eq {power: \on, light: \off}, map [\off \on], {power: 1, light: 0}

suite 'compact' ->
  test 'empty list as input' ->
    deep-eq [], compact []

  test 'empty object as input' ->
    deep-eq {}, compact {}

  test 'compacting array' ->
    deep-eq [1 true 'ha'], compact [0 1 false true '' 'ha']

  test 'compacting object' ->
    deep-eq {b:1, e: 'ha'}, compact {a: 0, b: 1, c: false, d: '', e: 'ha'}

suite 'filter' ->
  test 'empty list as input' ->
    deep-eq [], filter id, []

  test 'empty object as input' ->
    deep-eq {}, filter id, {}

  test 'empty string as input' ->
    eq '', filter id, ''

  test 'filtering array' ->
    deep-eq [2, 4], filter even, [1 to 5]

  test 'filtering object' ->
    deep-eq {b: 2}, filter (== 2), {a:1, b:2}

  test 'filtering string' ->
    eq 'abcc', filter (in [\a to \c]), 'abcdefcf'

  test 'filter on true returns original list' ->
    deep-eq [1 2 3], filter (-> true), [1 2 3]

  test 'filter on false returns empty list' ->
    deep-eq [], filter (-> false), [1 2 3]

suite 'reject' ->
  test 'empty list as input' ->
    deep-eq [], reject id, []

  test 'empty object as input' ->
    deep-eq {}, reject id, {}

  test 'empty string as input' ->
    eq '', reject id, ''

  test 'reject list' ->
    deep-eq [1 3 5], reject even, [1 to 5]

  test 'reject object' ->
    deep-eq {a: 1}, reject (==2), {a:1, b:2}

  test 'reject string' ->
    eq 'deff', reject (in [\a to \c]), 'abcdefcf'

  test 'reject on true returns empty list' ->
    deep-eq [], reject (-> true), [1 2 3]

  test 'reject on true returns original list' ->
    deep-eq [1 2 3], reject (-> false), [1 2 3]

suite 'partition' ->
  test 'empty list as input' ->
    deep-eq [[],[]], partition id, []

  test 'empty object as input' ->
    deep-eq [{}, {}], partition id, {}

  test 'empty string as input' ->
    deep-eq ['', ''], partition id, ''

  test 'partition list' ->
    deep-eq [[76 88 77 90],[49 58 43]], partition (>60), [49 58 76 43 88 77 90]

  test 'partition object' ->
    deep-eq [{b: 2}, {a: 1, c: 3}], partition (==2), {a:1, b:2, c:3}

  test 'partition string' ->
    deep-eq ['abcc', 'deff'], partition (in [\a to \c]), 'abcdefcf'

  test 'partition on true returns original list as passing, empty list as failing' ->
    deep-eq [[1 2 3],[]], partition (-> true), [1 2 3]

  test 'partition on false returns empty list as failing, empty list as passing' ->
    deep-eq [[], [1 2 3]], partition (-> false), [1 2 3]

suite 'find' ->
  test 'empty list as input' ->
    eq void, find id, []

  test 'empty object as input' ->
    eq void, find id, {}

  test 'empty string as input' ->
    eq void, find id, ''

  test 'find from list' ->
    eq 4, find even, [3 1 4 8 6]

  test 'find from object' ->
    eq 2, find (==2), {a:1, b:2}

  test 'find from string' ->
    eq 'b' find (== \b), 'abs'

  test 'finding nothing when function always false' ->
    eq void, find (-> false), [1 2 3]

  test 'find first item when function always true' ->
    eq 1, find (-> true), [1 2 3]

suite 'list portions' ->
  list = [1 2 3 4 5]
  string = 'abcde'

  suite 'head' ->
    test 'empty list as input' ->
      eq void, head []

    test 'empty string as input' ->
      eq void, head ''

    test 'list' ->
      eq 1, head list

    test 'string' ->
      eq 'a', head string

  suite 'tail' ->
    test 'empty list as input' ->
      eq void, tail []

    test 'empty string as input' ->
      eq void, tail ''

    test 'list' ->
      deep-eq [2 3 4 5], tail list

    test 'string' ->
      eq 'bcde', tail string

    test 'one element list' ->
      deep-eq [], tail [1]

  suite 'last' ->
    test 'empty list as input' ->
      eq void, last []

    test 'empty string as input' ->
      eq void, last ''

    test 'list' ->
      eq 5, last list

    test 'string' ->
      eq 'e', last string

    test 'one element list' ->
      eq 1, last [1]

  suite 'initial' ->
    test 'empty list as input' ->
      eq void, initial []

    test 'empty string as input' ->
      eq void, initial ''

    test 'list' ->
      deep-eq [1 2 3 4], initial list

    test 'string' ->
      eq 'abcd', initial string

    test 'one element list' ->
      deep-eq [], initial [1]

suite 'empty' ->
  test 'empty list as input' ->
    ok empty []

  test 'empty object as input' ->
    ok empty {}

  test 'empty string as input' ->
    ok empty ''

  test 'non-empty list as input' ->
    ok not empty [1]

  test 'non-empty object as input' ->
    ok not empty {x: 1}

  test 'non-empty string as input' ->
    ok not empty '1'

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

  test 'list as input' ->
    deep-eq <[ 0 1 2 ]>, keys [1 2 3]

suite 'len' ->
  test 'empty list as input' ->
    eq 0, len []

  test 'empty object as input' ->
    eq 0, len {}

  test 'empty string as input' ->
    eq 0, len ''

  test 'list as input' ->
    eq 5, len [1 2 3 4 5]

  test 'object as input' ->
    eq 3, len {x: 1, y: 2, z: 3}

  test 'string as input' ->
    eq 4, len 'abcd'

suite 'reverse' ->
  test 'empty list as input' ->
    deep-eq [], reverse []

  test 'empty string as input' ->
    eq '', reverse ''

  test 'reverse list, it is unmodified' ->
    list = [1 2 3 4 5]
    deep-eq [5 4 3 2 1], reverse list
    deep-eq [1 2 3 4 5], list

  test 'reverse string, it is unmodified' ->
    string = 'abcd'
    eq 'dcba', reverse string
    eq 'abcd', string

suite 'unique' ->
  test 'empty list as input' ->
    deep-eq [], unique []

  test 'empty string as input' ->
    eq '', unique ''

  test 'unique list' ->
    deep-eq [1,2,3,4,5,6], unique [1 1 2 3 3 4 5 5 5 5 5 6 6 6 6]

  test 'unique string' ->
    eq 'abcd', unique 'aaabbbcccdd'

suite 'fold' ->
  test 'empty list as input' ->
    eq 0, fold (+), 0, []

  test 'list as input' ->
    eq 12, fold (+), 0, [1 2 3 6]

  test 'foldl is alias' ->
    eq fold, foldl

suite 'fold1' ->
  test 'empty list as input' ->
    eq void, fold1 (+), []

  test 'list as input' ->
    eq 12, fold1 (+), [1 2 3 6]

  test 'foldl1 as alais' ->
    eq fold1, foldl1

suite 'foldr' ->
  test 'empty list as input' ->
    eq 0, foldr (+), 0, []

  test 'list as input' ->
    eq -1, foldr (-), 9, [1 2 3 4]

suite 'foldr1' ->
  test 'empty list as input' ->
    eq void, foldr1 (+), []

  test 'list as input' ->
    eq -1 foldr1 (-), [1 2 3 4 9]

suite 'unfoldr' ->
  test 'complex case' ->
    deep-eq [10,9,8,7,6,5,4,3,2,1], unfoldr (-> if it == 0 then null else [it, it - 1]), 10

  test 'returning null right away results in empty list' ->
    deep-eq [], unfoldr (-> null), 'a'

suite 'concat' ->
  test 'empty list as input' ->
    deep-eq [], concat []

  test 'multiple lists' ->
    deep-eq [1,2,3,4,5,6], concat [[1 2] [3 4] [5 6]]

suite 'concat-map' ->
  test 'empty list as input' ->
    deep-eq [], concat-map id, []

  test 'just using mapping' ->
    deep-eq [1 2 3], concat-map (+ 1), [0 1 2]

  test 'just using concatinating' ->
    deep-eq [1 2 3], concat-map id, [[1],[2],[3]]

  test 'using mapping and concatinating' ->
    deep-eq [1,1,2,1,2,3], concat-map (-> [1 to it]), [1 2 3]

suite 'flatten' ->
  test 'empty list as input' ->
    deep-eq [], flatten []

  test 'nested lists as input' ->
    deep-eq [1,2,3,4,5], flatten [1, [[2], 3], [4, [[5]]]]

suite 'difference' ->
  test 'empty list(s) as input' ->
    deep-eq [], difference [[]]
    deep-eq [], difference [[] []]

  test 'subtract nothing' ->
    deep-eq [1 2 3], difference [[1 2 3]]
    deep-eq [1 2 3], difference [[1 2 3] []]

  test 'subtract single element' ->
    deep-eq [2 3], difference [[1 2 3] [1]]

  test 'subtract multiple elements' ->
    deep-eq [1 3 4], difference [[1 2 3 4 5] [5 2 10] [9]]

suite 'intersection' ->
  test 'empty list(s) as input' ->
    deep-eq [], intersection [[]]
    deep-eq [], intersection [[] []]

  test 'no common elements' ->
    deep-eq [],intersection [[2 3] [9 8] [12 1] [99]]

  test 'some common elements' ->
    deep-eq [1 2], intersection [[1 2 3] [101 2 1 10] [2 1] [-1 0 1 2]]

  test 'all common elements' ->
    deep-eq [1 2 3], intersection [[1 2 3] [2 1 3] [3 1 2]]

suite 'union' ->
  test 'empty list(s) as input' ->
    deep-eq [], union [[]]
    deep-eq [], union [[] []]

  test 'list and empty list' ->
    deep-eq [1 2 3], union [[1 2 3] []]

  test 'with various' ->
    deep-eq [1 5 7 3], union [[1 5 7] [3 5] []]

suite 'count-by' ->
  test 'empty list as input' ->
    deep-eq [], count-by id, []

  test 'list of numbers' ->
    deep-eq {4: 1, 6: 2}, count-by floor, [4.2, 6.1, 6.4]

  test 'list of strings' ->
    deep-eq {3: 2, 5: 1}, count-by (.length), <[ one two three ]>

suite 'group-by' ->
  test 'empty list as input' ->
    deep-eq [], group-by id, []

  test 'list of numbers' ->
    deep-eq {4: [4.2], 6: [6.1 6.4]}, group-by floor, [4.2, 6.1, 6.4]

  test 'list of strings' ->
    deep-eq {3: <[ one two ]>, 5: <[ three ]>}, group-by (.length), <[ one two three ]>

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

  test 'string as input' ->
    ok any (== \M), 'mmmhMmm'
    ok not any (== \Z), 'mmmhMmm'
    ok not any (== \Z), ''

suite 'all' ->
  test 'empty string as input' ->
    ok all even, []

  test 'true' ->
    ok all even, [2 4 6]

  test 'false' ->
    ok not all even, [2 5 6]

  test 'string as input' ->
    ok all (== \M), 'MMMMMM'
    ok not all (== \M), 'MMMmMM'
    ok all (== \M), ''

suite 'compare' ->
  test 'simple case using id' ->
    eq 1, compare id, 2, 1
    eq -1, compare id, 1, 2
    eq 0, compare id, 1, 1

  test 'more complex case' ->
    eq -1, compare (.length), [1 to 3], [0 to 5]
    eq  1, compare (.length), [1 to 9], [0 to 5]
    eq  0, compare (.length), [1 to 4], [4 to 7]

suite 'sort' ->
  test 'empty list as input' ->
    deep-eq [], sort []

  test 'single digit numbers' ->
    deep-eq [1,2,3,4,5,6], sort [3 1 5 2 4 6]

  test 'multi digit numbers' ->
    deep-eq [2,5,6,12,334,4999], sort [334 12 5 2 4999 6]

suite 'sort-with' ->
  test 'empty list as input' ->
    deep-eq [], sort-with id, []

  test 'complex case' ->
    obj = one: 1, two: 2, three: 3
    deep-eq ['one','two','three'], sort-with (compare (obj.)), <[ three one two ]>

suite 'sort-by' ->
  test 'empty list as input' ->
    deep-eq [], sort-by id, []

  test 'complex case' ->
    arr =
      [1 2 3]
      [4]
      [5 6 7 8]
      [9 10]
    deep-eq [4,9,10,1,2,3,5,6,7,8], flatten sort-by (.length), arr

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

suite 'scan' ->
  test 'empty list as input' ->
    deep-eq [null], scan id, null, []

  test 'complex case' ->
    deep-eq [4,9,20,43], scan ((x, y) -> 2 * x + y), 4, [1 2 3]

  test 'scanl as alias' ->
    eq scan, scanl

suite 'scan1' ->
  test 'empty list as input' ->
    deep-eq void, scan1 id, []

  test 'complex case' ->
    deep-eq [1,3,6,10], scan1 (+), [1 2 3 4]

  test 'scanl1 as alias' ->
    eq scan1, scanl1

suite 'scanr' ->
  test 'empty list as input' ->
    deep-eq [null], scanr id, null, []

  test 'complex case' ->
    deep-eq [15,14,12,9,5], scanr (+), 5, [1 2 3 4]

suite 'scanr1' ->
  test 'empty list as input' ->
    deep-eq void, scanr1 id, []

  test 'complex case' ->
    deep-eq [10,9,7,4], scanr1 (+), [1 2 3 4]

suite 'replicate' ->
  test 'zero as input' ->
    deep-eq [], replicate 0 0
    deep-eq [], replicate 0 'a'

  test 'number as input' ->
    deep-eq [3,3,3,3], replicate 4 3

  test 'string as input' ->
    deep-eq <[ a a a a ]>, replicate 4 'a'

suite 'take' ->
  test 'empty list as input' ->
    deep-eq [], take 3 []

  test 'empty string as input' ->
    deep-eq '', take 3 ''

  test 'zero on list' ->
    deep-eq [], take 0 [1 2 3 4 5]

  test 'zero on string' ->
    eq '', take 0 'abcde'

  test 'negative number' ->
    deep-eq [], take -1 [1 2 3 4 5]

  test 'too big number' ->
    deep-eq [1 2 3 4 5], take 9 [1 2 3 4 5]

  test 'list' ->
    deep-eq [1 2 3], take 3 [1 2 3 4 5]

  test 'string' ->
    eq 'ab', take 2 'abcde'

suite 'drop' ->
  test 'empty list as input' ->
    deep-eq [], drop 3 []

  test 'empty string as input' ->
    deep-eq '', drop 3 ''

  test 'zero on list' ->
    deep-eq [1 2 3 4 5], drop 0 [1 2 3 4 5]

  test 'zero on string' ->
    eq 'abcde', drop 0 'abcde'

  test 'negative number' ->
    deep-eq [1 2 3 4 5], drop -1 [1 2 3 4 5]

  test 'too big number' ->
    deep-eq [], drop 9 [1 2 3 4 5]

  test 'list' ->
    deep-eq [4 5], drop 3 [1 2 3 4 5]

  test 'string' ->
    eq 'cde', drop 2 'abcde'

suite 'split-at' ->
  test 'empty list as input' ->
    deep-eq [[], []], split-at 3 []

  test 'empty string as input' ->
    deep-eq ['', ''], split-at 3 ''

  test 'zero on list' ->
    deep-eq [[], [1 2 3 4 5]], split-at 0 [1 2 3 4 5]

  test 'zero on string' ->
    deep-eq ['', 'abcde'], split-at 0 'abcde'

  test 'negative number' ->
    deep-eq [[], [1 2 3 4 5]], split-at -1 [1 2 3 4 5]

  test 'too big number' ->
    deep-eq [[1 2 3 4 5], []], split-at 9 [1 2 3 4 5]

  test 'list' ->
    deep-eq [[1 2 3], [4 5]], split-at 3 [1 2 3 4 5]

  test 'string' ->
    deep-eq ['ab', 'cde'], split-at 2 'abcde'

suite 'take-while' ->
  test 'empty list as input' ->
    deep-eq [], take-while id, []

  test 'empty string as input' ->
    eq '', take-while id, ''

  test 'list' ->
    deep-eq [1 3 5], take-while odd, [1 3 5 4 8 7 9]

  test 'string' ->
    eq 'mmmmm', take-while (is 'm'), 'mmmmmhmm'

suite 'drop-while' ->
  test 'empty list as input' ->
    deep-eq [], drop-while id, []

  test 'empty string as input' ->
    eq '', drop-while id, ''

  test 'list' ->
    deep-eq [7 9 10], drop-while even, [2 4 6 7 9 10]

  test 'string' ->
    eq 'hmm', drop-while (is \m), 'mmmmmhmm'

suite 'span' ->
  test 'empty list as input' ->
    deep-eq [[], []], span id, []

  test 'empty string as input' ->
    deep-eq ['', ''], span id, ''

  test 'list' ->
    deep-eq [[2 4 6], [7 9 10]], span even, [2 4 6 7 9 10]

  test 'string' ->
    deep-eq ['mmmmm', 'hmm'] span (is \m), 'mmmmmhmm'

suite 'break-list' ->
  test 'empty list as input' ->
    deep-eq [[], []], break-list id, []

  test 'empty string as input' ->
    deep-eq ['', ''], break-list id, ''

  test 'list' ->
    deep-eq [[1 2], [3 4 5]], break-list (== 3), [1 2 3 4 5]

  test 'string' ->
    deep-eq ['mmmmm', 'hmm'] break-list (is \h), 'mmmmmhmm'

suite 'zip' ->
  test 'empty lists as input' ->
    deep-eq [], zip [] []

  test 'equal length lists' ->
    deep-eq [[1 4], [2 5]], zip [1 2] [4 5]

  test 'first list shorter' ->
    deep-eq [[1 4], [2 5]], zip [1 2] [4 5 6]

  test 'second list shorter' ->
    deep-eq [[1 4], [2 5]], zip [1 2 3] [4 5]

suite 'zip-with' ->
  test 'empty lists as input' ->
    deep-eq [], zip-with id, [], []

  test 'equal length lists' ->
    deep-eq [4 4 4], zip-with (+), [1 2 3], [3 2 1]

  test 'first list shorter' ->
    deep-eq [5 7], zip-with (+), [1 2], [4 5 6]

  test 'second list shorter' ->
    deep-eq [5 7], zip-with (+), [1 2 3] [4 5]

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

suite 'curry' ->
  test 'simple function' ->
    add = (x, y) -> x + y
    add-curried = curry add
    add-four = add-curried 4
    eq 6 add-four 2

suite 'flip' ->
  test 'minus op' ->
    eq 10, (flip (-)) 5 15

suite 'fix' ->
  test 'single arg' ->
    eq 89, (fix (fib) -> (n) ->
      | n <= 1      => 1
      | otherwise   => fib(n-1) + fib(n-2))(10)

  test 'multi-arg variation' ->
    eq 89, (fix (fib) -> (n, minus=0) ->
      | (n - minus) <= 1 => 1
      | otherwise        => fib(n, minus+1) + fib(n, minus+2))(10)

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

suite 'max' ->
  test 'numbers' ->
    eq 3, max 3 3
    eq 3, max 2 3
    eq 3, max 3 2

  test 'characters' ->
    eq \b, max \a \b

suite 'min' ->
  test 'numbers' ->
    eq 0, min 9 0

  test 'characters' ->
    eq \a, min \a \b

suite 'negate' ->
  test 'zero' ->
    eq 0, negate 0

  test 'negative number' ->
    eq -2, negate 2

  test 'positive number' ->
    eq 3, negate -3

suite 'abs' ->
  test 'zero' ->
    eq 0, abs 0

  test 'negative number' ->
    eq 4 abs -4

  test 'positive number' ->
    eq 4 abs  4

suite 'signum' ->
  test 'zero' ->
    eq 0  signum 0

  test 'negative number' ->
    eq -1 signum -5.3

  test 'positive number' ->
    eq 1  signum 8

suite 'quot' ->
  test 'simple' ->
    eq -6 quot -20 3

suite 'rem' ->
  test 'simple' ->
    eq -2 rem -20 3

suite 'div' ->
  test 'simple' ->
    eq -7 div -20 3

suite 'mod' ->
  test 'simple' ->
    eq 1 mod -20 3

suite 'recip' ->
  test 'zero' ->
    eq Infinity, recip 0

  test 'larger than 1' ->
    eq 0.5, recip 2

  test 'between 0 and 1' ->
    eq 2, recip 0.5

suite 'pi' ->
  test 'constant' ->
    eq 3.141592653589793, pi

suite 'tau' ->
  test 'constant' ->
    eq 6.283185307179586, tau

suite 'exp' ->
  test 'simple' ->
    eq 2.718281828459045, exp 1

suite 'sqrt' ->
  test 'negative numbers' ->
    ok is-it-NaN sqrt -1

  test 'simple' ->
    eq 2 sqrt 4

suite 'ln' ->
  test 'simple' ->
    eq 0.6931471805599453, ln 2

suite 'pow' ->
  test 'simple' ->
    eq 4, pow 2 2
    eq 4, pow -2 2

  test 'with negative numbers' ->
    eq 0.25, pow 2 -2

  test 'between one and zero' ->
    eq 4, pow 16 0.5

suite 'sin' ->
  test 'zero' ->
    eq 0, sin 0

  test 'one' ->
    eq 0.8414709848078965, sin 1

suite 'tan' ->
  test 'zero' ->
    eq 0, tan 0

  test 'one' ->
    eq 1.5574077246549023, tan 1

suite 'cos' ->
  test 'zero' ->
    eq 1, cos 0

  test 'one' ->
    eq 0.5403023058681398, cos 1

suite 'acos' ->
  test 'number' ->
    eq 1.4706289056333368, acos 0.1

suite 'asin' ->
  test 'number' ->
    eq 1.5707963267948966, asin 1

suite 'atan' ->
  test 'number' ->
    eq 0.7853981633974483, atan 1

suite 'atan2' ->
  test 'number' ->
    eq 0.4636476090008061, atan2 1 2

suite 'truncate' ->
  test 'zero' ->
    eq 0, truncate 0

  test 'positive number' ->
    eq  1 truncate  1.5

  test 'negative number' ->
    eq -1 truncate -1.5

suite 'round' ->
  test 'up' ->
    eq 1 round 0.6
    eq 1 round 0.5

  test 'down' ->
    eq 0 round 0.4

suite 'ceiling' ->
  test 'zero' ->
    eq 0, ceiling 0

  test 'positive number' ->
    eq 1, ceiling 0.1

  test 'negative number' ->
    eq 0, ceiling -0.9

suite 'floor' ->
  test 'zero' ->
    eq 0, floor 0

  test 'positive number' ->
    eq 0, floor 0.9

  test 'negative number' ->
    eq -1, floor -0.1

suite 'is-it-NaN' ->
  test 'true' ->
    ok is-it-NaN Math.sqrt -1

  test 'false' ->
    ok not is-it-NaN '0'

suite 'even' ->
  test 'true' ->
    ok even 0
    ok even -2

  test 'false' ->
    ok not even 7

suite 'odd' ->
  test 'true' ->
    ok odd 3

  test 'false' ->
    ok not odd -4
    ok not odd 0

suite 'gcd' ->
  test 'some numbers' ->
    eq 6 gcd 12 18

suite 'lcm' ->
  test 'some numbers' ->
    eq 36, lcm 12 18
