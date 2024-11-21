import 'package:flutter/material.dart';

class BasicCalculatorUI extends StatefulWidget {
  @override
  _BasicCalculatorUIState createState() => _BasicCalculatorUIState();
}

class _BasicCalculatorUIState extends State<BasicCalculatorUI> {
  String _expression = '';
  String _result = '';
  bool _showTrigButtons = false; // Trạng thái hiển thị các nút con

  void _appendToExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  void _calculateResult() {
    setState(() {
      _result = _expression; // Giả lập kết quả (tùy chỉnh logic tính toán tại đây)
      _expression = '';
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
        body: Column(
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
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
            ),
            const Divider(),
            Stack(
              children: [
                _buildCalculatorButtons(),
                if (_showTrigButtons) _buildTrigButtonsOverlay(), // Nút con xuất hiện phía trên
              ],
            ),
          ],
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
        _buildButtonRow(['More', '0', '=', '+']),
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
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          onPressed: () {
            if (value == '=') {
              _calculateResult();
            } else if (value == 'C') {
              _clear();
            } else if (value == 'More') {
              setState(() {
                _showTrigButtons = !_showTrigButtons; // Bật/tắt hiển thị nút con
              });
            } else {
              _appendToExpression(value);
            }
          },
          child: Text(
            value,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildTrigButtonsOverlay() {
    return Positioned(
      bottom: 120, // Điều chỉnh vị trí để hiển thị ngay trên nút More
      left: 0,
      right: 0,
      child: Row(
        children: ['sin', 'cos', 'tan'].map((value) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: () {
                  _appendToExpression(value);
                  setState(() {
                    _showTrigButtons = false; // Tắt nút con khi đã chọn
                  });
                },
                child: Text(
                  value,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
