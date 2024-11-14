// ProgrammerCalculatorUI.dart
import 'package:flutter/material.dart';
import 'ProgrammerCalculatorHandler.dart';

class ProgrammerCalculatorUI extends StatefulWidget {
  @override
  _ProgrammerCalculatorUIState createState() => _ProgrammerCalculatorUIState();
}

class _ProgrammerCalculatorUIState extends State<ProgrammerCalculatorUI> {
  final TextEditingController _inputController = TextEditingController();
  String _result = '';
  String _selectedBase = 'Binary';
  
  final List<String> _bases = ['Binary', 'Decimal', 'Hexadecimal', 'Octal'];

  // Updates the result display with conversions
  void _calculateResult() {
    String input = _inputController.text;
    setState(() {
      _result = ProgrammerCalculatorHandler.evaluate(input, _selectedBase);
    });
  }

  // UI for selecting base type (Binary, Decimal, Hexadecimal, Octal)
  Widget _buildBaseSelector() {
    return DropdownButton<String>(
      value: _selectedBase,
      onChanged: (String? newValue) {
        setState(() {
          _selectedBase = newValue!;
        });
      },
      items: _bases.map<DropdownMenuItem<String>>((String base) {
        return DropdownMenuItem<String>(
          value: base,
          child: Text(base),
        );
      }).toList(),
    );
  }

  // UI for the input and conversion display
  Widget _buildInputSection() {
    return Column(
      children: [
        TextField(
          controller: _inputController,
          decoration: InputDecoration(
            labelText: 'Enter Value',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _calculateResult,
          child: Text('Convert'),
        ),
        SizedBox(height: 10),
        Text(
          _result,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Bitwise operations section
  Widget _buildBitwiseOperations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBitwiseButton('AND', () {
              int result = ProgrammerCalculatorHandler.performBitwiseAnd(5, 3);
              setState(() {
                _result = 'AND Result: $result';
              });
            }),
            _buildBitwiseButton('OR', () {
              int result = ProgrammerCalculatorHandler.performBitwiseOr(5, 3);
              setState(() {
                _result = 'OR Result: $result';
              });
            }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBitwiseButton('XOR', () {
              int result = ProgrammerCalculatorHandler.performBitwiseXor(5, 3);
              setState(() {
                _result = 'XOR Result: $result';
              });
            }),
            _buildBitwiseButton('NOT', () {
              int result = ProgrammerCalculatorHandler.performBitwiseNot(5);
              setState(() {
                _result = 'NOT Result: $result';
              });
            }),
          ],
        ),
      ],
    );
  }

  // Helper method to create bitwise operation buttons
  Widget _buildBitwiseButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Programmer Calculator')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildBaseSelector(),
              SizedBox(height: 20),
              _buildInputSection(),
              SizedBox(height: 20),
              _buildBitwiseOperations(),
            ],
          ),
        ),
      ),
    );
  }
}
