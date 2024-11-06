// BasicCalculatorUI.dart
import 'package:flutter/material.dart';
import 'BasicCalculatorHandler.dart';

class BasicCalculatorUI extends StatefulWidget {
  @override
  _BasicCalculatorUIState createState() => _BasicCalculatorUIState();
}

class _BasicCalculatorUIState extends State<BasicCalculatorUI> {
  String _expression = '';
  String _result = '';

  void _appendToExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  void _calculateResult() {
    double result = BasicCalculatorHandler.evaluate(_expression);
    setState(() {
      _result = result.toString();
      _expression = ''; // Clear expression after calculation
    });
  }

  void _clear() {
    setState(() {
      _expression = '';
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Basic Calculator'),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  _expression,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  _result,
                  style: TextStyle(fontSize: 24, color: Colors.grey[700]),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  children: [
                    ...['7', '8', '9', '/'].map((value) => _buildButton(value)),
                    ...['4', '5', '6', '*'].map((value) => _buildButton(value)),
                    ...['1', '2', '3', '-'].map((value) => _buildButton(value)),
                    ...['C', '0', '=', '+'].map((value) => _buildButton(value)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String value) {
    return Container(
      margin: EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal, // Button color
          padding: EdgeInsets.symmetric(vertical: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () {
          if (value == '=') {
            _calculateResult();
          } else if (value == 'C') {
            _clear();
          } else {
            _appendToExpression(value);
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
