import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Máy tính Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>
    with SingleTickerProviderStateMixin {
  String _expression = '';
  String _result = '';
  bool _showMoreButtons = false;
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _amount = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == 'C') {
        _expression = '';
        _result = '';
      } else {
        _expression += buttonText;
      }
    });
  }

  void _calculateResult() {
    String jsonInput = json.encode({'expression': _expression});
    String jsonOutput = CalculatorLogic.processExpression(jsonInput);
    Map<String, dynamic> output = json.decode(jsonOutput);

    setState(() {
      _result = output['error'] ?? output['result'];
    });
  }

  void _convertCurrency() {
    double conversionRate = _getConversionRate(_fromCurrency, _toCurrency);
    setState(() {
      _result = (_amount * conversionRate).toStringAsFixed(2);
    });
  }

  double _getConversionRate(String from, String to) {
    const rates = {
      'USD': {'EUR': 0.85, 'JPY': 110.0, 'VND': 23000.0},
      'EUR': {'USD': 1.18, 'JPY': 130.0, 'VND': 27000.0},
      'JPY': {'USD': 0.0091, 'EUR': 0.0077, 'VND': 200.0},
      'VND': {'USD': 0.000043, 'EUR': 0.000037, 'JPY': 0.005},
    };
    return rates[from]?[to] ?? 1.0;
  }

  Widget _buildCurrencyCalculatorUI() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: 'Nhập số tiền'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            _amount = double.tryParse(value) ?? 0;
          },
        ),
        _buildCurrencyDropdowns(),
        ElevatedButton(
          onPressed: _convertCurrency,
          child: const Text('Chuyển đổi'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Kết quả: $_result',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrencyDropdowns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCurrencyDropdown((value) {
          setState(() {
            _fromCurrency = value!;
          });
        }),
        const Text('→'),
        _buildCurrencyDropdown((value) {
          setState(() {
            _toCurrency = value!;
          });
        }),
      ],
    );
  }

  Widget _buildCurrencyDropdown(ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: _fromCurrency,
      items: <String>['USD', 'EUR', 'JPY', 'VND'].map((String currency) {
        return DropdownMenuItem<String>(
          value: currency,
          child: Text(currency),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  // Basic Calculator UI
  Widget _buildBasicCalculatorUI() {
    return Column(
      children: [
        ..._buildCalculatorRows([
          ['7', '8', '9', '/'],
          ['4', '5', '6', 'X'],
          ['1', '2', '3', '-'],
          ['.', '0', 'C', '+'],
          ['='],
        ]),
        if (_showMoreButtons) _buildMoreButtons(),
        _buildToggleButton(),
      ],
    );
  }

  // Programmer Calculator UI
  Widget _buildProgrammerCalculatorUI() {
    return Column(
      children: [
        ..._buildCalculatorRows([
          ['A', 'B', 'C', 'D'],
          ['E', 'F', 'C', '='],
          ['DEC', 'HEX', 'OCT', 'BIN'],
          ['AND', 'OR', 'XOR', 'NOT'],
          ['<<', '>>', '+', '-'],
          ['*', '/'],
        ]),
      ],
    );
  }

  // Shared methods
  List<Widget> _buildCalculatorRows(List<List<String>> rows) {
    return rows.map((row) {
      return Row(
        children: row.map((buttonText) => _buildButton(buttonText)).toList(),
      );
    }).toList();
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          child: Text(buttonText),
          onPressed: () => _onButtonPressed(buttonText),
        ),
      ),
    );
  }

  Widget _buildMoreButtons() {
    return Column(
      children: [
        Row(children: [
          _buildButton('Ans'),
          _buildButton('π'),
          _buildButton('x²'),
        ]),
        Row(children: [
          _buildButton('%'),
          _buildButton('x!'),
          _buildButton('E'),
        ]),
      ],
    );
  }

  Widget _buildToggleButton() {
    return Row(
      children: [
        ElevatedButton(
          child: Text(_showMoreButtons ? 'Ít hơn' : 'Thêm'),
          onPressed: () {
            setState(() {
              _showMoreButtons = !_showMoreButtons;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Máy tính Flutter')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildDisplay(),
            const Divider(),
            _buildTabBar(),
            _buildTabBarView(),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplay() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.centerRight,
          child: Text(_expression, style: const TextStyle(fontSize: 24)),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.centerRight,
          child: Text(
            _result,
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Basic'),
          Tab(text: 'Binary'),
          Tab(text: 'Currency'),
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildBasicCalculatorUI(),
          _buildProgrammerCalculatorUI(),
          _buildCurrencyCalculatorUI(),
        ],
      ),
    );
  }
}

// Calculator Logic
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
    expression = expression.replaceAll(' ', '');
    expression = _handleFactorials(expression);

    List<String> tokens = expression
        .split(RegExp(r'(\+|\-|\*|\/|\^|%|\!|\&|\||\^|\~|\<\<|\>\>)'));
    List<String> operators = expression.split(RegExp(r'[0-9\.]+'))
      ..removeWhere((e) => e.isEmpty);

    for (int i = 0; i < operators.length; i++) {
      if (operators[i] == '*' ||
          operators[i] == '/' ||
          operators[i] == '^' ||
          operators[i] == '%') {
        double a = double.parse(tokens[i]);
        double b = double.parse(tokens[i + 1]);
        double result;

        switch (operators[i]) {
          case '*':
            result = a * b;
            break;
          case '/':
            result = a / b;
            break;
          case '^':
            result = pow(a, b).toDouble();
            break;
          case '%':
            result = a % b;
            break;
          default:
            result = 0;
        }

        tokens[i] = result.toString();
        tokens.removeAt(i + 1);
        operators.removeAt(i);
        i--;
      }
    }

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

  static String _handleFactorials(String expression) {
    final factorialRegex = RegExp(r'(\d+)\!');
    while (factorialRegex.hasMatch(expression)) {
      final match = factorialRegex.firstMatch(expression)!;
      int number = int.parse(match.group(1)!);
      int factorialResult = _factorial(number);
      expression =
          expression.replaceFirst(match.group(0)!, factorialResult.toString());
    }
    return expression;
  }

  static int _factorial(int n) {
    if (n <= 1) return 1;
    return n * _factorial(n - 1);
  }
}
