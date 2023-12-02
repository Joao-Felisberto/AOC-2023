import std/strutils

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
