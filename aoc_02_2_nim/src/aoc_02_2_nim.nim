import std/re
import std/strutils
import std/tables

let game_re = re".*?(;|$)"
let turn_re = re"(?<number>[0-9]+) (?<color>\w+)"

proc part_2(fname: string): int =
  var power_sum = 0
  for ln in lines fname:
    var mins = {"red": 0, "green": 0, "blue": 0}.to_table()

    for game in findAll(ln, game_re):
      for turn in findAll(game, turn_re):
        # nim re does not support capture groups
        let t = split(turn)
        let 
          n = parseInt(t[0])
          color = t[1]
        
        if mins[color] < n:
          mins[color] = n

    let power = mins["red"] * mins["green"] * mins["blue"]
    # echo power
    power_sum += power
        
  return power_sum



when isMainModule:
  echo part_2("input.txt")
