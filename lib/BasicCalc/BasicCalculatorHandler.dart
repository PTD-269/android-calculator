class BasicCalculatorHandler {
  static double evaluate(String expression) {
    expression = _removeSpaces(expression);
    List<String> tokens = _splitTokens(expression);
    List<String> operators = _extractOperators(expression);

    tokens = _performMultiplicationAndDivision(tokens, operators);
    return _performAdditionAndSubtraction(tokens, operators);
  }

  static String _removeSpaces(String expression) {
    return expression.replaceAll(' ', '');
  }

  static List<String> _splitTokens(String expression) {
    return expression.split(RegExp(r'(\+|\-|\*|\/)'));
  }

  static List<String> _extractOperators(String expression) {
    return expression.split(RegExp(r'[0-9\.]+'))..removeWhere((e) => e.isEmpty);
  }

  static List<String> _performMultiplicationAndDivision(
      List<String> tokens, List<String> operators) {
    for (int i = 0; i < operators.length; i++) {
      if (operators[i] == 'x' || operators[i] == '/') {
        double a = double.parse(tokens[i]);
        double b = double.parse(tokens[i + 1]);
        double result = operators[i] == 'x' ? a * b : a / b;
        tokens[i] = result.toString();
        tokens.removeAt(i + 1);
        operators.removeAt(i);
        i--;
      }
    }
    return tokens;
  }

  static double _performAdditionAndSubtraction(
      List<String> tokens, List<String> operators) {
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
