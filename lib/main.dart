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
      title: 'Máy tính Flutter',
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

class _CalculatorScreenState extends State<CalculatorScreen>
    with SingleTickerProviderStateMixin {
  String _expression = '';
  String _result = '';
  bool _showMoreButtons = false; // Biến trạng thái cho nút "More"

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, vsync: this); // Ba tab: Cơ bản, Nhị phân, Tiền tệ
  }

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
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          child: Text(buttonText),
          onPressed: () => _onButtonPressed(buttonText),
        ),
      ),
    );
  }

  Widget _buildBasicCalculatorUI() {
    return Column(
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
          _buildButton('X')
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
        if (_showMoreButtons)
          Column(
            children: [
              Row(children: [
                _buildButton('Ans'),
                _buildButton('π'),
                _buildButton('x²')
              ]),
              Row(children: [
                _buildButton('%'),
                _buildButton('x!'),
                _buildButton('E')
              ]),
            ],
          ),
        Row(
          children: [
            ElevatedButton(
              child: Text(_showMoreButtons ? 'Ít hơn' : 'Thêm'),
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

  Widget _buildProgrammerCalculatorUI() {
    return Column(
      children: [
        // Row for Hexadecimal input
        Row(children: [
          _buildButton('A'),
          _buildButton('B'),
          _buildButton('C'),
          _buildButton('D'),
        ]),
        Row(children: [
          _buildButton('E'),
          _buildButton('F'),
          _buildButton('C'), // Clear button
          _buildButton('='), // Equals button
        ]),

        // Row for number systems and bitwise operations
        Row(children: [
          _buildButton('DEC'), // Decimal button
          _buildButton('HEX'), // Hexadecimal button
          _buildButton('OCT'), // Octal button
          _buildButton('BIN'), // Binary button
        ]),

        // Additional programmer-specific operations
        Row(children: [
          _buildButton('AND'),
          _buildButton('OR'),
          _buildButton('XOR'),
          _buildButton('NOT'),
        ]),

        Row(children: [
          _buildButton('<<'), // Left shift
          _buildButton('>>'), // Right shift
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Máy tính Flutter')),
      body: SingleChildScrollView(
        // Sử dụng SingleChildScrollView để cuộn nội dung nếu cần
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


            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical:
                  8.0), // Điều chỉnh giá trị này để xích thanh trượt lên trên
              child: TabBar(
                controller: _tabController,
                indicatorColor:
                Colors.transparent,
                tabs: const [
                  Tab(text: 'Basic'),
                  Tab(text: 'Binary'),
                  Tab(text: 'Currency'), // Thêm tab cho máy tính tiền tệ
                ],
              ),
            ),


            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.5, // Điều chỉnh chiều cao nếu cần
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBasicCalculatorUI(),
                  _buildProgrammerCalculatorUI(),
                  _buildCurrencyCalculatorUI(), // Gọi giao diện máy tính tiền tệ
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
