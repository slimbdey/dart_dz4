import 'package:dz4/utils/index.dart';
import 'package:test/test.dart';

void main() {
  final varMap = <String, int>{
    'x': 10,
    'y': 20,
  };

  void insure(String expr, int result) {
    test(expr, () {
      expect(evaluator(expr, varMap), equals(result));
    });
  }

  void insureThrows(String expr) {
    test(expr, () {
      expect(() => evaluator(expr, varMap), throwsException);
    });
  }

  group('Evaluator unit tests', () {
    insure('10*5+4/2-1', 51);
    insure('100 + 200 / 2 * 5 + 7', 607);
    insure('100 + 200 / (2 * 5) + 7', 127);
    insure('(100 +200)/ 2*5+7 ^2', 799);
    insure('10x + 5', 105);
    insure('20x + 7y', 340);
    insureThrows('100 + 200 / 2 * 5) + 7'); // throws 'missing ('
    insureThrows('20X + 7y'); // throws 'Unknown variable: X'
  });
}
