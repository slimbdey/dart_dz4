List<String> splitByOperators(String rawExpression) {
  final result = <String>[];
  String current = '';

  void flush() {
    if (current.isNotEmpty) {
      result.add(current);
      current = '';
    }
  }

  for (int i = 0; i < rawExpression.length; i++) {
    final String ch = rawExpression[i];

    if (ch.trim().isEmpty) {
      continue;
    }

    if (!isNumber(ch)) {
      flush();
      result.add(ch);
      continue;
    }

    current += ch;
  }

  flush();

  return result;
}

bool isNumber(String char) {
  return RegExp(r'^\d+$').hasMatch(char);
}

bool isIdentifier(String token) =>
    RegExp(r'^[A-Za-z_][A-Za-z0-9_]*$').hasMatch(token);

void test(String expr, Map<String, int> varMap,
    int Function(String s, Map<String, int> varMap) handler) {
  try {
    int result = handler(expr, varMap);
    print(result);
  } catch (e) {
    print(e.toString());
  }
}
