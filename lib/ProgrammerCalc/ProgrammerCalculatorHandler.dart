// static mode variables
class Modes {
  // Static constant variables for different number systems
  static const String binary = 'binary';
  static const String octal = 'octal';
  static const String decimal = 'decimal';
  static const String hexadecimal = 'hexadecimal';
  Modes();
}

class ProgrammerCalculatorHandler {
  // Allowed characters for each mode
  static const _modeCharacters = {
    Modes.binary: '01',
    Modes.octal: '01234567',
    Modes.decimal: '0123456789',
    Modes.hexadecimal: '0123456789ABCDEFabcdef',
  };

  //Mode choosing
  static Modes Mode = Modes();

  /// Evaluate an expression and return results in all modes
  static Map<String, String>? evaluateExpression(
      String expression, String mode) {
    if (!_validateMode(mode) || !_validateExpression(expression, mode)) {
      return null;
    }

    try {
      // Parse and evaluate the expression
      final sanitizedExpression = expression.replaceAllMapped(
        RegExp(r'[0-9A-Fa-f]+'),
        (match) => _parseValue(match.group(0)!, mode).toString(),
      );
      final result = _evaluate(sanitizedExpression);

      // Return results in all modes
      return {
        Modes.binary: _formatResult(result, Modes.binary),
        Modes.octal: _formatResult(result, Modes.octal),
        Modes.decimal: _formatResult(result, Modes.decimal),
        Modes.hexadecimal: _formatResult(result, Modes.hexadecimal),
      };
    } catch (e) {
      return null;
    }
  }

  /// Validate the mode
  static bool _validateMode(String mode) {
    return _modeCharacters.containsKey(mode);
  }

  /// Validate the expression against the mode
  static bool _validateExpression(String expression, String mode) {
    final allowedChars = _modeCharacters[mode]!;
    final validChars = expression.replaceAll(RegExp(r'[+\-*/&|^~()\s]'), '');
    for (var char in validChars.split('')) {
      if (!allowedChars.contains(char.toUpperCase()) &&
          !allowedChars.contains(char.toLowerCase())) {
        return false;
      }
    }
    return true;
  }

  /// Parse a value from the given mode to decimal
  static int _parseValue(String value, String mode) {
    return int.parse(value, radix: _radixForMode(mode));
  }

  /// Convert a result from decimal back to the given mode
  static String _formatResult(int value, String mode) {
    switch (mode) {
      case Modes.binary:
        return value.toRadixString(2).padLeft(8, '0'); // 8-bit alignment
      case Modes.octal:
        return value.toRadixString(8).padLeft(3, '0');
      case Modes.decimal:
        return value.toString();
      case Modes.hexadecimal:
        return '0x${value.toRadixString(16).toUpperCase().padLeft(2, '0')}';
      default:
        return '';
    }
  }

  /// Determine the radix for the given mode
  static int _radixForMode(String mode) {
    switch (mode) {
      case Modes.binary:
        return 2;
      case Modes.octal:
        return 8;
      case Modes.decimal:
        return 10;
      case Modes.hexadecimal:
        return 16;
      default:
        return 10;
    }
  }

  /// Evaluate the sanitized mathematical expression
  static int _evaluate(String expression) {
    // Handle NOT operator (~) first
    expression = expression.replaceAllMapped(
      RegExp(r'~\s*(\d+)'),
      (match) => (-(int.parse(match.group(1)!) - 1)).toString(),
    );
    return _simpleEvaluate(expression);
  }

  /// Simple evaluator for mathematical and bitwise operations
  static int _simpleEvaluate(String expression) {
    // Remove all whitespace
    expression = expression.replaceAll(RegExp(r'\s+'), '');

    // Handle negative numbers at the start
    if (expression.startsWith('-')) {
      expression = '0' + expression;
    }

    // Split by operators while preserving them
    final parts = expression.split(RegExp(r'(?<=[-+&|^])|(?=[-+&|^])'));

    if (parts.isEmpty) {
      throw ArgumentError('Empty expression');
    }

    // Start with the first number
    var result = int.parse(parts[0]);

    // Process each operator and number pair
    for (var i = 1; i < parts.length - 1; i += 2) {
      final operator = parts[i];
      final nextNum = int.parse(parts[i + 1]);

      switch (operator) {
        case '+':
          result += nextNum;
          break;
        case '-':
          result -= nextNum;
          break;
        case '&':
          result &= nextNum;
          break;
        case '|':
          result |= nextNum;
          break;
        case '^':
          result ^= nextNum;
          break;
        default:
          throw ArgumentError('Unsupported operator: $operator');
      }
    }

    return result;
  }
}

void main() {
  // Test cases
  final testCases = [
    {'expr': '', 'mode': Modes.binary},
    {'expr': 'FF | A5', 'mode': Modes.hexadecimal},
    {'expr': '15 + 7', 'mode': Modes.decimal},
    {'expr': '77 & 44', 'mode': Modes.octal},
    {'expr': '1010 ^ 0101', 'mode': Modes.binary},
    {'expr': 'invalid', 'mode': Modes.binary}, // Invalid test case
  ];

  for (var test in testCases) {
    print('\nExpression: ${test['expr']} (${test['mode']} mode)');
    final results = ProgrammerCalculatorHandler.evaluateExpression(
      test['expr']!,
      test['mode']!,
    );
    if (results == null) {
      print('Invalid expression or mode.');
    } else {
      print('Results:');
      results.forEach((mode, value) {
        print('  $mode: $value');
      });
    }
  }
}
