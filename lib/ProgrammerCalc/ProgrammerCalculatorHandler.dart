// ProgrammerCalculatorHandler.dart
class ProgrammerCalculatorHandler {
  static int binaryToDecimal(String binary) {
    return int.parse(binary, radix: 2);
  }

  static int hexadecimalToDecimal(String hex) {
    return int.parse(hex, radix: 16);
  }

  static int octalToDecimal(String octal) {
    return int.parse(octal, radix: 8);
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

    try {
      switch (base) {
        case 'Binary':
          decimalValue = binaryToDecimal(input);
          break;
        case 'Hexadecimal':
          decimalValue = hexadecimalToDecimal(input);
          break;
        case 'Octal':
          decimalValue = octalToDecimal(input);
          break;
        case 'Decimal':
        default:
          decimalValue = int.parse(input);
          break;
      }
    } catch (e) {
      throw FormatException("Invalid Input");
    }

    return 'Decimal: $decimalValue\n'
        'Binary: ${decimalToBinary(decimalValue)}\n'
        'Hexadecimal: ${decimalToHexadecimal(decimalValue)}\n'
        'Octal: ${decimalToOctal(decimalValue)}';
  }
}
