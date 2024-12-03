import 'package:flutter/material.dart';
import 'ProgrammerCalculatorHandler.dart';

class ProgrammerCalculatorUI extends StatefulWidget {
  @override
  _ProgrammerCalculatorUIState createState() => _ProgrammerCalculatorUIState();
}

class _ProgrammerCalculatorUIState extends State<ProgrammerCalculatorUI> {
  String _input = '';
  String _resultDecimal = '0';
  String _resultBinary = '0';
  String _resultHexadecimal = '0';
  String _resultOctal = '0';
  String _base = 'Hexadecimal';

  void _appendToInput(String value) {
    setState(() {
      _input += value;
    });
  }

  void _calculateResult() {
    try {
      String evaluationResult =
          ProgrammerCalculatorHandler.evaluate(_input, _base);

      List<String> results = evaluationResult.split('\n');
      setState(() {
        _resultDecimal = results[0].split(': ')[1];
        _resultBinary = results[1].split(': ')[1];
        _resultHexadecimal = results[2].split(': ')[1];
        _resultOctal = results[3].split(': ')[1];
        _input = '';
      });
    } catch (e) {
      setState(() {
        _resultDecimal = 'Invalid Input';
        _resultBinary = 'Invalid Input';
        _resultHexadecimal = 'Invalid Input';
        _resultOctal = 'Invalid Input';
      });
    }
  }

  void _clear() {
    setState(() {
      _input = '';
      _resultDecimal = '0';
      _resultBinary = '0';
      _resultHexadecimal = '0';
      _resultOctal = '0';
    });
  }

  void _setBase(String base) {
    setState(() {
      _base = base;
      _input = '';
      _clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programmer Calculator'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildDisplaySection(),
            const SizedBox(height: 50),
            _buildBaseSwitcher(),
            const SizedBox(height: 40),
            _buildButtonsGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplaySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Input ($_base): $_input',
          style: const TextStyle(fontSize: 25),
        ),
        const SizedBox(height: 20),
        Text(
          'Decimal: $_resultDecimal',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Binary: $_resultBinary',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Hexadecimal: $_resultHexadecimal',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Octal: $_resultOctal',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildBaseSwitcher() {
    final bases = ['Binary', 'Decimal', 'Hexadecimal', 'Octal'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: bases
          .map((base) => ElevatedButton(
                onPressed: () => _setBase(base),
                child: Text(base),
              ))
          .toList(),
    );
  }

  Widget _buildButtonsGrid() {
    final buttonLabels = [
      ['A', '%', '(', ')', 'AC'],
      ['B', 'AND', 'OR', 'XOR', 'NOT'],
      ['C', '7', '8', '9', '/'],
      ['D', '4', '5', '6', 'X'],
      ['E', '1', '2', '3', '-'],
      ['F', '.', '0', '=', '+']
    ];
    return Column(
      children: buttonLabels
          .map((row) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: row.map((label) => _buildButton(label)).toList(),
              ))
          .toList(),
    );
  }

  Widget _buildButton(String value) {
    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: () {
          if (value == '=') {
            _calculateResult();
          } else if (value == 'AC') {
            setState(() {
              _input = '';
            });
          } else {
            _appendToInput(value);
          }
        },
        child: Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
