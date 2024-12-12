import 'package:flutter/material.dart';
import '../widgets/CalculatorKeyboard.dart'; 
import '../BasicCalc/BasicCalculatorHandler.dart';
import '../Widgets/MoreOptionsMenu.dart';
class BasicCalculatorUI extends StatefulWidget {
  @override
  _BasicCalculatorUIState createState() => _BasicCalculatorUIState();
}

class _BasicCalculatorUIState extends State<BasicCalculatorUI> {
  String _expression = '';
  String _result = '';

  void _appendToExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  void _calculateResult() {
    double? result = BasicCalculatorHandler.evaluateExpression(_expression);
    if (result != null) {
      result = double.parse(result.toStringAsFixed(4));
    }
    setState(() {
      _result = result.toString();
      _expression = ''; 
    });
  }

  void _clear() {
    setState(() {
      _expression = '';
      _result = '';
    });
  }

 // Phương thức mở MoreOptionsMenu
  void _openMoreFunctions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("More Functions"),
          content: MoreOptionsMenu(
            onOptionSelected: (String option) {
              _appendToExpression(option); // Gọi thêm vào biểu thức khi chọn chức năng
              Navigator.pop(context); // Đóng Dialog sau khi chọn
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Calculator'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                _expression,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                _result,
                style: TextStyle(fontSize: 24, color: Colors.grey[700]),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: CalculatorKeyboard(
                onButtonPressed: (value) {
                  if (value == '=') {
                    _calculateResult();
                  } else if (value == 'C') {
                    _clear();
                  } else if (value == 'More') {
                    _openMoreFunctions();
                      
                  } else {
                    _appendToExpression(value);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}