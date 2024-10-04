import 'package:flutter/material.dart';
import 'dart:convert';
import 'calculator_logic.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

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
      if (output['error'] != null) {
        _result = output['error'];
      } else {
        _result = output['result'];
      }
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        child: Text(buttonText),
        onPressed: () => _onButtonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(_expression, style: TextStyle(fontSize: 24)),
          ),
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(_result,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('/')
              ]),
              Row(children: [
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('*')
              ]),
              Row(children: [
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-')
              ]),
              Row(children: [
                _buildButton('.'),
                _buildButton('0'),
                _buildButton('C'),
                _buildButton('+')
              ]),
              Row(children: [_buildButton('=')]),
            ],
          )
        ],
      ),
    );
  }
}
