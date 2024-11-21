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
  bool _showBitwiseOptions = false;

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

  // Number buttons section (0-9)
  Widget _buildNumberButtons() {
    return Column(
      children: [
        for (var row in [
          [1, 2, 3],
          [4, 5, 6],
          [7, 8, 9],
          [0]
        ])
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row
                .map(
                  (number) => SizedBox(
                    width: 70, // Set the width to match Basic UI buttons
                    height: 70, // Set the height to match Basic UI buttons
                    child: ElevatedButton(
                      onPressed: () {
                        _inputController.text += number.toString();
                      },
                      child: Text(
                        number.toString(),
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  // Bitwise operations section
  Widget _buildBitwiseOperations() {
    return Visibility(
      visible: _showBitwiseOptions,
      child: Column(
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
      ),
    );
  }

  // Helper method to create bitwise operation buttons
  Widget _buildBitwiseButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }

  // Toggle for "More" section
  Widget _buildMoreButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _showBitwiseOptions = !_showBitwiseOptions;
        });
      },
      child: Text(_showBitwiseOptions ? 'Hide Options' : 'More'),
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
              _buildNumberButtons(),
              SizedBox(height: 20),
              _buildMoreButton(),
              SizedBox(height: 10),
              _buildBitwiseOperations(),
            ],
          ),
        ),
      ),
    );
  }
}
