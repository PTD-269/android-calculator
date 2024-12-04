import 'package:flutter/material.dart';
import 'ProgrammerCalculatorHandler.dart';
import '../Widgets/CalculatorKeyboard.dart';
import "../Widgets/ProgrammerKeyboard.dart";

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
        _input = '';
      });
    } catch (e) {
      setState(() {
        _result = 'Invalid Input: ${e.toString()}';
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
      _input = '';
      _result = '';
    });
  }

  void _onButtonPressed(String value) {
    if (value == '=') {
      _calculateResult();
    } else if (value == 'C') {
      _clear();
    } else {
      _appendToInput(value);
    }
  }

  // Widget tái sử dụng cho các nút chế độ
  Widget _buildBaseButton(String label, String base) {
    return ElevatedButton(
      onPressed: () => _setBase(base),
      style: ElevatedButton.styleFrom(
        backgroundColor: _base == base ? Colors.green.shade700 : Colors.green, 
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10), // Kích thước nút nhỏ
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white), // Cỡ chữ nhỏ
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Đảm bảo các phần không bị giãn ra quá nhiều
        crossAxisAlignment: CrossAxisAlignment.start, // Căn chỉnh theo chiều ngang trái
        children: [
          // Phần Input và Result (hiển thị song song)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Cột chứa các nút chế độ
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBaseButton('Binary', 'Binary'),
                  SizedBox(height: 10),
                  _buildBaseButton('Decimal', 'Decimal'),
                  SizedBox(height: 10),
                  _buildBaseButton('Hexadecimal', 'Hexadecimal'),
                  SizedBox(height: 10),
                  _buildBaseButton('Octal', 'Octal'),
                ],
              ),
              // Cột chứa phần Input và Result
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Input ($_base): $_input',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Result:\n$_result',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),

          // Phần Calculator Keyboard (phần này chiếm không gian còn lại)
          Expanded(
            child: ProgrammerKeyboard(onButtonPressed: _onButtonPressed),
          ),
        ],
      ),
    );
  }
}
