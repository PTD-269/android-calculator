import 'package:flutter/material.dart';
import 'dart:convert';
import 'calculator_logic.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';
  bool _showMoreButtons = false; // Biến trạng thái cho nút "More"
  int _selectedIndex = 0; // Chỉ mục của trang được chọn (Binary, Currency)

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

  // Hiển thị UI máy tính cơ bản
  Widget _buildBasicCalculatorUI() {
    return Column(
      children: [
        Row(children: [
          _buildButton('7'),
          _buildButton('8'),
          _buildButton('9'),
          _buildButton('/'),
        ]),
        Row(children: [
          _buildButton('4'),
          _buildButton('5'),
          _buildButton('6'),
          _buildButton('X'),
        ]),
        Row(children: [
          _buildButton('1'),
          _buildButton('2'),
          _buildButton('3'),
          _buildButton('-'),
        ]),
        Row(children: [
          _buildButton('.'),
          _buildButton('0'),
          _buildButton('C'),
          _buildButton('+'),
        ]),
        Row(children: [_buildButton('=')]),
        if (_showMoreButtons)
          Column(
            children: [
              Row(children: [
                _buildButton('Ans'),
                _buildButton('π'),
                _buildButton('x²'),
              ]),
              Row(children: [
                _buildButton('%'),
                _buildButton('x!'),
                _buildButton('E'),
              ]),
            ],
          ),
        Row(
          children: [
            ElevatedButton(
              child: Text(_showMoreButtons ? 'Less' : 'More'),
              onPressed: () {
                setState(() {
                  _showMoreButtons = !_showMoreButtons;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  // Hiển thị UI máy tính nhị phân
  Widget _buildProgrammerCalculatorUI() {
    return Column(
      children: [
        Row(children: [
          _buildButton('A'),
          _buildButton('B'),
          _buildButton('C'),
          _buildButton('D'),
        ]),
        Row(children: [
          _buildButton('E'),
          _buildButton('F'),
          _buildButton('C'), // Nút Clear
          _buildButton('='), // Nút Equals
        ]),
        Row(children: [
          _buildButton('DEC'),
          _buildButton('HEX'),
          _buildButton('OCT'),
          _buildButton('BIN'),
        ]),
        Row(children: [
          _buildButton('AND'),
          _buildButton('OR'),
          _buildButton('XOR'),
          _buildButton('NOT'),
        ]),
        Row(children: [
          _buildButton('<<'),
          _buildButton('>>'),
          _buildButton('+'),
          _buildButton('-'),
        ]),
        Row(children: [
          _buildButton('*'),
          _buildButton('/'),
        ]),
      ],
    );
  }

  // Hiển thị UI máy tính tiền tệ
  Widget _buildCurrencyCalculatorUI() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: 'Nhập số tiền'),
          keyboardType: TextInputType.number,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton<String>(
              value: 'USD',
              items: <String>['USD', 'EUR', 'JPY', 'VND'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Xử lý sự kiện chọn đơn vị tiền
              },
            ),
            const Text('→'),
            DropdownButton<String>(
              value: 'EUR',
              items: <String>['USD', 'EUR', 'JPY', 'VND'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Xử lý sự kiện chọn đơn vị tiền
              },
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            // Chuyển đổi tiền tệ (chưa có logic)
          },
          child: const Text('Chuyển đổi'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Kết quả: ',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }

  // Điều hướng giữa các máy tính
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Đóng drawer sau khi chọn
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Máy tính Flutter')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerRight,
              child: Text(_expression, style: const TextStyle(fontSize: 24)),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerRight,
              child: Text(_result,
                  style: const TextStyle(
                      fontSize: 48, fontWeight: FontWeight.bold)),
            ),
            const Divider(),
            if (_selectedIndex == 0)
              _buildBasicCalculatorUI()
            else if (_selectedIndex == 1)
              _buildProgrammerCalculatorUI()
            else if (_selectedIndex == 2)
                _buildCurrencyCalculatorUI()
              else
                _buildScientificCalculatorUI(),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: Text('Choose type of calculator'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Basic calculator'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('Programmer calculator'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Currency calculator'),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              title: Text('Scientific Calculator'),
              leading: const Icon(Icons.science),
              onTap: () => _onItemTapped(3),
            )
          ],
        ),
      ),
    );
  }

  // Hiển thị UI máy tính khoa học
  Widget _buildScientificCalculatorUI() {
    return Column(
      children: [
        Row(children: [
          _buildButton('sin'),
          _buildButton('cos'),
          _buildButton('tan'),
          _buildButton('√'),
          _buildButton('^'), // Lũy thừa
        ]),
        Row(children: [
          _buildButton('('),
          _buildButton(')'),
          _buildButton('7'),
          _buildButton('8'),
          _buildButton('9'),
        ]),
        Row(children: [
          _buildButton('4'),
          _buildButton('5'),
          _buildButton('6'),
          _buildButton('/'),
          _buildButton('C'), // Nút Clear
        ]),
        Row(children: [
          _buildButton('1'),
          _buildButton('2'),
          _buildButton('3'),
          _buildButton('+'),
          _buildButton('.'),
        ]),
        Row(children: [
          _buildButton('0'),
          _buildButton('='),
          _buildButton('π'),
          _buildButton('x²'),
          _buildButton('%'),
        ]),
      ],
    );
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // Giữ góc vuông
            ),
          ),
          child: Text(buttonText),
          onPressed: () => _onButtonPressed(buttonText),
        ),
      ),
    );
  }
}
