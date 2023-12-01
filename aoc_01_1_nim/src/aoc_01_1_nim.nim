import std/strutils


#[
proc charToInt(c: char): int =
  case c
  of '0':
    return 0
  of '1':
    return 1
  of '2':
    return 2
  of '3':
    return 3
  of '4':
    return 4
  of '5':
    return 5
  of '6':
    return 6
  of '7':
    return 7
  of '8':
    return 8
  of '9':
    return 9
  else:
    return -1
]#

when isMainModule:
  var sum: int = 0
  for ln in lines "input.txt":
    var first_num_c: char = '\0'
    var last_num_c: char = '\0'
    for c in ln:
      if c in {'0'..'9'}:
        if first_num_c == '\0':
          first_num_c = c
        last_num_c = c
    let ln_num = $first_num_c & $last_num_c 
    sum += parseInt(ln_num)
  echo sum
