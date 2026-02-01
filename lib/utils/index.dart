import 'class_stack.dart';
import 'enums.dart';
import 'helpers.dart';

final values = Stack<int>();
final operations = Stack<Operation>();

int evaluator(String s, Map<String, int> varMap) {
  final expression = splitByOperators(s);

  for (int i = 0; i < expression.length; i++) {
    String token = expression[i];
    handleToken(token, varMap);
  }

  while (!operations.isEmpty) {
    calculateOperation();
  }

  return values.pop();
}

void handleToken(String token, Map<String, int> varMap) {
  if (isIdentifier(token)) {
    if (!varMap.containsKey(token)) {
      throw FormatException('Unknown variable: $token');
    }

    if (operations.isEmpty || operations.peek() != Operation.multiply) {
      operations.push(Operation.multiply);
    }

    return values.push(varMap[token] as int);
  }

  if (isNumber(token)) {
    return values.push(int.parse(token));
  }

  try {
    handleParenthesis(token);
  } catch (e) {
    if (e is FormatException) rethrow;

    return;
  }

  final newOperation = Operation.fromString(token) as Operation;

  while (!operations.isEmpty &&
      operations.peek() != Operation.lparen &&
      (operations.peek() > newOperation ||
          (operations.peek().priority() == newOperation.priority() &&
              newOperation != Operation.power))) {
    calculateOperation();
  }

  operations.push(newOperation);
}

void calculateOperation() {
  int val2 = values.pop();
  int val1 = values.pop();
  Operation operation = operations.pop();
  values.push(operation.apply(val1, val2));
}

void handleParenthesis(String token) {
  if (token == '(') {
    operations.push(Operation.lparen);
    throw Exception();
  }

  if (token == ')') {
    while (!operations.isEmpty && operations.peek() != Operation.lparen) {
      calculateOperation();
    }

    if (operations.isEmpty) {
      throw FormatException('Mismatched parentheses: missing "("');
    }

    operations.pop();
    throw Exception();
  }
}
