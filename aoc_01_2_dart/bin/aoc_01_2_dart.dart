import 'dart:io';

import 'package:aoc_01_2_dart/aoc_01_2_dart.dart';

final Map<String, int> nameToNumberTranslation = const {
  // "zero": 0,
  "one": 1,
  "two": 2,
  "three": 3,
  "four": 4,
  "five": 5,
  "six": 6,
  "seven": 7,
  "eight": 8,
  "nine": 9,
   //"0": 0,
  "1": 1,
  "2": 2,
  "3": 3,
  "4": 4,
  "5": 5,
  "6": 6,
  "7": 7,
  "8": 8,
  "9": 9,
};

// 54782 too high
// 54750 ????????
// 54476 too low
// 54699 too low
void main(List<String> arguments) {
  final List<String> lines = File('input.txt').readAsLinesSync();
  // final List<String> lines = File('input_test_2.txt').readAsLinesSync();
  int sum = 0;
  for (final String line in lines) {
    // print(line);
    var matcher = WordMatcher(nameToNumberTranslation.keys.toList());
    int first = -1;
    int last = -1;
    for (int c in line.runes) {
      final String? consumed = matcher.consume(c);
      if (consumed == null) continue;

      // print(consumed);
      if (first == -1) {
        first = nameToNumberTranslation[consumed]!; // cannot fail
        matcher = WordMatcher(nameToNumberTranslation.keys
            .map((e) => String.fromCharCodes(e.runes.toList().reversed))
            .toList());
        // print(matcher.words.map(String.fromCharCodes).toString());
        break;
      } // else
    }
    for (int c in line.runes.toList().reversed) {
      // print(String.fromCharCode(c));
      final String? consumed = matcher.consume(c);
      if (consumed == null) continue;

      // print(consumed);
      last = nameToNumberTranslation[String.fromCharCodes(consumed.runes.toList().reversed)]!; // cannot fail
      break;
    }
    // if (int.parse("$last") > 0) {
    print("$first$last");
    sum += int.parse("$first$last");
    // } else {
    // print("$first");
    // sum += int.parse("$first");
    // }
  }
  print(sum);
}
