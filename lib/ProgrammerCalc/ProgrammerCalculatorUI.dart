// ProgrammerCalculatorUI.dart
import 'package:flutter/material.dart';
import 'ProgrammerCalculatorHandler.dart';

class ProgrammerCalculatorUI extends StatefulWidget {
  @override
  _ProgrammerCalculatorUIState createState() => _ProgrammerCalculatorUIState();
}

class _ProgrammerCalculatorUIState extends State<ProgrammerCalculatorUI> {
  String _input = '';
  String _result = '';
  String _base = 'Decimal';

  void _appendToInput(String value) {
    setState(() {
      _input += value;
    });
  }

  void _calculateResult() {
    try {
      String evaluationResult =
          ProgrammerCalculatorHandler.evaluate(_input, _base);
      setState(() {
        _result = evaluationResult;
        _input = ''; // Clear input after calculation
      });
    } catch (e) {
      setState(() {
        _result = 'Invalid Input';
      });
    }
  }

  void _clear() {
    setState(() {
      _input = '';
      _result = '';
    });
  }

  void _setBase(String base) {
    setState(() {
      _base = base;
      _input = ''; // Clear input when changing base
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              'Input ($_base): $_input',
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              'Result:\n$_result',
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _setBase('Binary'),
                child: Text('Binary'),
              ),
              ElevatedButton(
                onPressed: () => _setBase('Decimal'),
                child: Text('Decimal'),
              ),
              ElevatedButton(
                onPressed: () => _setBase('Hexadecimal'),
                child: Text('Hexadecimal'),
              ),
              ElevatedButton(
                onPressed: () => _setBase('Octal'),
                child: Text('Octal'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('AND'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('OR'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('XOR'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton('0'),
                    _buildButton('C'),
                    _buildButton('='),
                    _buildButton('NOT'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String value) {
    return Container(
      margin: EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          fixedSize: Size(70, 70), // Fixed size for buttons
        ),
        onPressed: () {
          if (value == '=') {
            _calculateResult();
          } else if (value == 'C') {
            _clear();
          } else if (value == 'AND' || value == 'OR' || value == 'XOR') {
            // Handle bitwise operations
            int a = int.parse(_input);
            int b = int.parse(_input); // For simplicity, using the same input
            int result;
            if (value == 'AND') {
              result = ProgrammerCalculatorHandler.performBitwiseAnd(a, b);
            } else if (value == 'OR') {
              result = ProgrammerCalculatorHandler.performBitwiseOr(a, b);
            } else {
              result = ProgrammerCalculatorHandler.performBitwiseXor(a, b);
            }
            setState(() {
              _result = 'Result: $result';
              _input = ''; // Clear input after calculation
            });
          } else if (value == 'NOT') {
            int a = int.parse(_input);
            int result = ProgrammerCalculatorHandler.performBitwiseNot(a);
            setState(() {
              _result = 'Result: $result';
              _input = ''; // Clear input after calculation
            });
          } else {
            _appendToInput(value);
          }
        },
        child: Text(
          value,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
