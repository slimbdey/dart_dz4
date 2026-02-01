import 'utils/helpers.dart';
import 'utils/index.dart';

void main(List<String> args) {
  final varMap = <String, int>{
    'x': 10,
    'y': 20,
  };

  String expression1 = '10*5+4/2-1'; // 51
  String expression2 = '100 + 200 / 2 * 5 + 7'; // 607
  String expression3 = '100 + 200 / (2 * 5) + 7'; // 127
  String expression4 = '(100 +200)/ 2*5+7 ^2'; // 799
  String expression5 = '100 + 200 / 2 * 5) + 7'; // throws 'missing ('
  String expression6 = '10x + 5'; // 105
  String expression7 = '20x + 7y'; // 340
  String expression8 = '20X + 7y'; // throws 'Unknown variable: X'

  test(expression1, varMap, evaluator);
  test(expression2, varMap, evaluator);
  test(expression3, varMap, evaluator);
  test(expression4, varMap, evaluator);
  test(expression5, varMap, evaluator);
  test(expression6, varMap, evaluator);
  test(expression7, varMap, evaluator);
  test(expression8, varMap, evaluator);
}
