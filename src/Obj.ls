values = (object) ->
  [x for , x of object]

keys = (object) ->
  [x for x of object]

pairs-to-obj= (object) ->
  {[x.0, x.1] for x in object}

obj-to-pairs = (object) ->
  [[key, value] for key, value of object]

lists-to-obj= (keys, values) -->
  {[key, values[i]] for key, i in keys}

obj-to-lists = (object) ->
  keys = []
  values = []
  for key, value of object
    keys.push key
    values.push value
  [keys, values]

empty = (object) ->
  for x of object then return false
  true

each = (f, object) -->
  for , x of object then f x
  object

map = (f, object) -->
  {[k, f x] for k, x of object}

compact = (object) -->
  {[k, x] for k, x of object when x}

filter = (f, object) -->
  {[k, x] for k, x of object when f x}

reject = (f, object) -->
  {[k, x] for k, x of object when not f x}

partition = (f, object) -->
  passed = {}
  failed = {}
  for k, x of object
    (if f x then passed else failed)[k] = x
  [passed, failed]

find = (f, object) -->
  for , x of object when f x then return x
  void

module.exports = {
  values, keys,
  pairs-to-obj, obj-to-pairs, lists-to-obj, obj-to-lists,

  empty, each, map, filter, compact, reject, partition, find,
}
