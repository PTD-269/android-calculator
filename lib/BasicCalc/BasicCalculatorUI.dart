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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(16),
                child: Text(
                  _expression,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(16),
                child: Text(
                  _result,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
              ),
              const Divider(),
              _buildCalculatorButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalculatorButtons() {
    return Column(
      children: [
        _buildButtonRow(['7', '8', '9', '/']),
        _buildButtonRow(['4', '5', '6', '*']),
        _buildButtonRow(['1', '2', '3', '-']),
        _buildButtonRow(['C', '0', '=', '+']),
      ],
    );
  }

  Widget _buildButtonRow(List<String> values) {
    return Row(
      children: values.map((value) => _buildButton(value)).toList(),
    );
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),  // Reduced padding for compactness
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding: EdgeInsets.symmetric(vertical: 16.0),  // Compact padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
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
            style: TextStyle(fontSize: 20, color: Colors.white),  // Adjusted font size for compactness
          ),
        ),
      ),
    );
  }
}
