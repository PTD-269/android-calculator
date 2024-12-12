import 'dart:math' as math;

class BasicCalculatorHandler {
  // Static method to evaluate a mathematical expression
  static double? evaluateExpression(String expression) {
    try {
      return _evaluate(expression);
    } catch (e) {
      return null;
    }
  }

  static double _evaluate(String expression) {
    // Helper function to evaluate trigonometric functions
    double evaluateTrigFunction(String func, double value) {
      double radians = value * math.pi / 180;
      switch (func.toLowerCase()) {
        case 'sin':
          return math.sin(radians);
        case 'cos':
          return math.cos(radians);
        case 'tan':
          return math.tan(radians);
        case 'cot':
          return 1 / math.tan(radians);
        default:
          throw FormatException('Unknown function: $func');
      }
    }

    expression = expression.replaceAll(' ', '');
    List<double> values = [];
    List<String> operators = [];

    int i = 0;
    while (i < expression.length) {
      if (RegExp(r'[0-9]').hasMatch(expression[i])) {
        String numStr = '';
        while (i < expression.length && RegExp(r'[0-9.]').hasMatch(expression[i])) {
          numStr += expression[i];
          i++;
        }
        values.add(double.parse(numStr));
        continue;
      }

      if (RegExp(r'[a-z]').hasMatch(expression[i])) {
        String func = '';
        while (i < expression.length && RegExp(r'[a-z]').hasMatch(expression[i])) {
          func += expression[i];
          i++;
        }

        if (i < expression.length && expression[i] == '(') {
          i++;
          String innerValue = '';
          int parenthesesCount = 1;
          
          while (i < expression.length && parenthesesCount > 0) {
            if (expression[i] == '(') parenthesesCount++;
            if (expression[i] == ')') parenthesesCount--;
            if (parenthesesCount > 0) innerValue += expression[i];
            i++;
          }

          double result = _evaluate(innerValue);
          values.add(evaluateTrigFunction(func, result));
        }
        continue;
      }

      if ('+-*/()'.contains(expression[i])) {
        if (expression[i] == '(') {
          operators.add(expression[i]);
        } else if (expression[i] == ')') {
          while (operators.isNotEmpty && operators.last != '(') {
            _calculateTop(values, operators);
          }
          operators.removeLast(); // Remove '('
        } else {
          while (operators.isNotEmpty && 
                 _precedence(operators.last) >= _precedence(expression[i])) {
            _calculateTop(values, operators);
          }
          operators.add(expression[i]);
        }
        i++;
        continue;
      }
      
      i++;
    }

    while (operators.isNotEmpty) {
      _calculateTop(values, operators);
    }

    return values.last;
  }

  static int _precedence(String op) {
    switch (op) {
      case '+':
      case '-':
        return 1;
      case '*':
      case '/':
        return 2;
      default:
        return 0;
    }
  }

  static void _calculateTop(List<double> values, List<String> operators) {
    if (values.length < 2 || operators.isEmpty) return;
    
    double b = values.removeLast();
    double a = values.removeLast();
    String op = operators.removeLast();

    switch (op) {
      case '+':
        values.add(a + b);
        break;
      case '-':
        values.add(a - b);
        break;
      case '*':
        values.add(a * b);
        break;
      case '/':
        if (b == 0) throw Exception('Division by zero');
        values.add(a / b);
        break;
    }
  }
}

