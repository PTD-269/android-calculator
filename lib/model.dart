class CalculatorModel {
  double _result = 0;

  double get result => _result;

  void add(double a, double b) {
    _result = a + b;
  }

  void subtract(double a, double b) {
    _result = a - b;
  }

  void multiply(double a, double b) {
    _result = a * b;
  }

  void divide(double a, double b) {
    if (b != 0) {
      _result = a / b;
    } else {
      _result = double.infinity;
    }
  }
}
