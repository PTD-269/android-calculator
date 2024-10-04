import 'dart:convert';

class CalculatorLogic {
  static String processExpression(String jsonInput) {
    Map<String, dynamic> input = json.decode(jsonInput);
    String expression = input['expression'];

    try {
      double result = _evaluate(expression);
      return json.encode({'result': result.toString(), 'error': null});
    } catch (e) {
      return json
          .encode({'result': null, 'error': 'Error: Invalid expression'});
    }
  }

  static double _evaluate(String expression) {
    // Remove any spaces from the expression
    expression = expression.replaceAll(' ', '');

    // Split the expression into numbers and operators
    List<String> tokens = expression.split(RegExp(r'(\+|\-|\*|\/)'));
    List<String> operators = expression.split(RegExp(r'[0-9\.]+'))
      ..removeWhere((e) => e.isEmpty);

    // Perform multiplication and division first
    for (int i = 0; i < operators.length; i++) {
      if (operators[i] == '*' || operators[i] == '/') {
        double a = double.parse(tokens[i]);
        double b = double.parse(tokens[i + 1]);
        double result = operators[i] == '*' ? a * b : a / b;
        tokens[i] = result.toString();
        tokens.removeAt(i + 1);
        operators.removeAt(i);
        i--;
      }
    }

    // Perform addition and subtraction
    double result = double.parse(tokens[0]);
    for (int i = 0; i < operators.length; i++) {
      double b = double.parse(tokens[i + 1]);
      if (operators[i] == '+') {
        result += b;
      } else if (operators[i] == '-') {
        result -= b;
      }
    }

    return result;
  }
}
