import 'package:flutter/material.dart';
import 'ProgrammerCalculatorHandler.dart';
import '../Widgets/CalculatorKeyboard.dart';
import "../Widgets/ProgrammerKeyboard.dart";

class ProgrammerCalculatorUI extends StatefulWidget {
  @override
  _ProgrammerCalculatorUIState createState() =>
      _ProgrammerCalculatorUIState();
}

class _ProgrammerCalculatorUIState extends State<ProgrammerCalculatorUI> {
  String _input = '';  // Biểu thức người dùng nhập vào
  String _result = ''; // Kết quả sau khi tính toán
  String _base = 'decimal';  // Hệ cơ sở hiện tại (binary, octal, decimal, hexadecimal)

  // Thêm ký tự vào biểu thức
  void _appendToInput(String value) {
    setState(() {
      _input += value;
    });
  }

  // Tính toán kết quả
  void _calculateResult() {
    try {
      // Tính toán với handler và trả về kết quả trong tất cả các hệ cơ sở
      var results = ProgrammerCalculatorHandler.evaluateExpression(_input, _base);

      setState(() {
        if (results == null) {
          _result = 'Invalid Expression';
        } else {
          _result = 'Binary: ${results['binary']}\n' +
                    'Octal: ${results['octal']}\n' +
                    'Decimal: ${results['decimal']}\n' +
                    'Hexadecimal: ${results['hexadecimal']}';
        }

        // Sau khi tính toán, reset input
        _input = '';
      });
    } catch (e) {
      setState(() {
        _result = 'Invalid Input: ${e.toString()}';
      });
    }
  }

  // Xóa input và kết quả
  void _clear() {
    setState(() {
      _input = '';
      _result = '';
    });
  }

  // Đặt lại hệ cơ sở tính toán
  void _setBase(String base) {
    setState(() {
      _base = base;
      _input = '';
      _result = '';
    });
  }

  // Xử lý khi người dùng bấm một phím
  void _onButtonPressed(String value) {
    if (value == '=') {
      _calculateResult();
    } else if (value == 'C') {
      _clear();
    } else {
      _appendToInput(value);
    }
  }

  // Widget để xây dựng các nút chọn hệ cơ sở
  Widget _buildBaseButton(String label, String base) {
    return ElevatedButton(
      onPressed: () => _setBase(base),
      style: ElevatedButton.styleFrom(
        backgroundColor: _base == base ? Colors.green.shade700 : Colors.green, 
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white), 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, 
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          // Các nút chọn hệ cơ sở
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Các nút hệ cơ sở
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBaseButton('Binary', 'binary'),
                  SizedBox(height: 10),
                  _buildBaseButton('Decimal', 'decimal'),
                  SizedBox(height: 10),
                  _buildBaseButton('Hexadecimal', 'hexadecimal'),
                  SizedBox(height: 10),
                  _buildBaseButton('Octal', 'octal'),
                ],
              ),
              // Hiển thị input và kết quả
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

          // Bàn phím tính toán (ProgrammerKeyboard)
          Expanded(
            child: ProgrammerKeyboard(onButtonPressed: _onButtonPressed),
          ),
        ],
      ),
    );
  }
}
