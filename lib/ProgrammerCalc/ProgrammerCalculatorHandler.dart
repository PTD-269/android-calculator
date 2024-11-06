// ProgrammerCalculatorHandler.dart
class ProgrammerCalculatorHandler {
  static int binaryToDecimal(String binary) {
    return int.parse(binary, radix: 2);
  }

  static String decimalToBinary(int decimal) {
    return decimal.toRadixString(2);
  }

  static String decimalToHexadecimal(int decimal) {
    return decimal.toRadixString(16).toUpperCase();
  }

  static String decimalToOctal(int decimal) {
    return decimal.toRadixString(8);
  }

  static int performBitwiseAnd(int a, int b) {
    return a & b;
  }

  static int performBitwiseOr(int a, int b) {
    return a | b;
  }

  static int performBitwiseXor(int a, int b) {
    return a ^ b;
  }

  static int performBitwiseNot(int a) {
    return ~a;
  }

  static String evaluate(String input, String base) {
    int decimalValue;
    if (base == 'Binary') {
      decimalValue = binaryToDecimal(input);
    } else {
      decimalValue = int.parse(input);
    }
    return 'Decimal: $decimalValue\n'
        'Binary: ${decimalToBinary(decimalValue)}\n'
        'Hexadecimal: ${decimalToHexadecimal(decimalValue)}\n'
        'Octal: ${decimalToOctal(decimalValue)}';
  }
}
