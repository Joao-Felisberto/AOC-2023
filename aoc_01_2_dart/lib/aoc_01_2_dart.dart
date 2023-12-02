class WordMatcher {
  final List<List<int>> words;
  final List<int> pointers;
  int sinceLast = 0;

  WordMatcher(List<String> words)
      : words = words.map((e) => e.runes.toList()).toList(),
        pointers = List<int>.filled(words.length, 0, growable: false);

  String? consume(int c) {
    sinceLast += 1;
    for (int i = 0; i < pointers.length; i++) {
      final int expected = words[i][pointers[i]];
      if (expected == c) {
        if (pointers[i] == words[i].length - 1) {
          // for (int j = 0; j < pointers.length; pointers[j++] = 0) {}
          pointers[i] = 0;
          // return sinceLast > words[i].length ? String.fromCharCodes(words[i]) : null;
          return String.fromCharCodes(words[i]);
        }

        pointers[i]++;
      } else if (words[i][0] == c) {
        pointers[i] = 1;
      } else {
        pointers[i] = 0;
      }
    }

    return null;
  }
}
