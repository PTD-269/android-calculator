import 'package:flutter/material.dart';
import 'ProgrammerCalculatorHandler.dart';
import '../Widgets/CalculatorKeyboard.dart'; 

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

  // Hàm xử lý khi nhấn nút từ CalculatorKeyboard
  void _onButtonPressed(String value) {
    if (value == '=') {
      _calculateResult();
    } else if (value == 'C') {
      _clear();
    } else {
      _appendToInput(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Phần input và kết quả
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
          
          // Thay đổi phần nút Binary, Decimal, Hexadecimal, Octal
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Đặt các nút sang trái
            children: [
              ElevatedButton(
                onPressed: () => _setBase('Binary'),
                child: Text('Binary'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => _setBase('Decimal'),
                child: Text('Decimal'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => _setBase('Hexadecimal'),
                child: Text('Hexadecimal'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => _setBase('Octal'),
                child: Text('Octal'),
              ),
            ],
          ),
          SizedBox(height: 20),

          // Phần bàn phím với CalculatorKeyboard
          Expanded(
            child: CalculatorKeyboard(onButtonPressed: _onButtonPressed),
          ),
        ],
      ),
    );
  }
}
