import 'model.dart';

class CalculatorController {
  final CalculatorModel _model = CalculatorModel();

  double calculate(double a, double b, String operation) {
    switch (operation) {
      case '+':
        _model.add(a, b);
        break;
      case '-':
        _model.subtract(a, b);
        break;
      case '*':
        _model.multiply(a, b);
        break;
      case '/':
        _model.divide(a, b);
        break;
      default:
        throw ArgumentError('Invalid operation');
    }
    return _model.result;
  }
}
