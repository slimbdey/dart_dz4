import 'dart:math';

enum TokenType {
  number,
  variable,
  operation,
  parenthesis,
}

enum Operation {
  plus,
  minus,
  multiply,
  divide,
  power,
  lparen;

  int priority() => switch (this) {
        Operation.power => 3,
        Operation.multiply || Operation.divide => 2,
        Operation.plus || Operation.minus => 1,
        Operation.lparen => 0,
      };

  bool operator >(Operation other) => priority() > other.priority();

  int apply(int arg1, int arg2) => switch (this) {
        Operation.plus => arg1 + arg2,
        Operation.minus => arg1 - arg2,
        Operation.multiply => arg1 * arg2,
        Operation.power => pow(arg1, arg2).toInt(),
        Operation.divide => arg2 != 0 ? arg1 ~/ arg2 : throw ArgumentError(),
        Operation.lparen => throw StateError('lparen should never be applied'),
      };

  static Operation? fromString(String op) => switch (op) {
        '+' => Operation.plus,
        '-' => Operation.minus,
        '*' => Operation.multiply,
        '/' => Operation.divide,
        '^' => Operation.power,
        '(' => Operation.lparen,
        ')' => null,
        _ => null,
      };
}
