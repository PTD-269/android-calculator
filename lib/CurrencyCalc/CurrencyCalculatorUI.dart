// CurrencyCalculatorUI.dart
import 'package:flutter/material.dart';
import 'CurrencyCalculatorHandler.dart';

class CurrencyCalculatorUI extends StatefulWidget {
  @override
  _CurrencyCalculatorUIState createState() => _CurrencyCalculatorUIState();
}

class _CurrencyCalculatorUIState extends State<CurrencyCalculatorUI> {
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _amount = 0.0;
  String _result = '';
  Color _fromCurrencyColor = Colors.blueAccent;  // Biến màu chữ cho đồng tiền xuất phát
  Color _toCurrencyColor = Colors.blueAccent;    // Biến màu chữ cho đồng tiền đích

  final TextEditingController _amountController = TextEditingController();

  void _convertCurrency() {
    try {
      double amount = double.parse(_amountController.text);
      double convertedAmount =
          CurrencyCalculatorHandler.convert(_fromCurrency, _toCurrency, amount);
      setState(() {
        _result =
            '$amount $_fromCurrency = ${convertedAmount.toStringAsFixed(2)} $_toCurrency';
      });
    } catch (e) {
      setState(() {
        _result = 'Invalid input';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Giúp giao diện tránh bàn phím
      backgroundColor: Color(0xFFf0f4f7), // Màu nền sáng nhẹ
      appBar: AppBar(
        title: Text('Currency Converter'),
        backgroundColor: Colors.blueAccent, // Màu xanh dương cho appBar
      ),
      body: SingleChildScrollView( // Bao quanh với SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Trường nhập liệu cho Amount
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.blueAccent), // Màu label xanh dương
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent), // Viền xanh dương
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent), // Viền khi focus xanh dương
                ),
              ),
              keyboardType: TextInputType.number, // Hiển thị bàn phím số
              textInputAction: TextInputAction.done, // Khi nhấn "Done"
              onSubmitted: (value) {
                _convertCurrency(); // Khi nhấn Enter, thực hiện chuyển đổi
              },
            ),
            SizedBox(height: 20),
            // Dropdown cho đồng tiền xuất phát
            DropdownButton<String>(
              value: _fromCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  _fromCurrency = newValue!;
                  _fromCurrencyColor = Colors.black; // Đổi màu chữ thành đen khi chọn
                });
              },
              items: CurrencyCalculatorHandler.getAvailableCurrencies()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              dropdownColor: Colors.blueAccent, // Màu nền xanh cho dropdown
              style: TextStyle(color: _fromCurrencyColor), // Màu chữ thay đổi
            ),
            SizedBox(height: 20),
            // Dropdown cho đồng tiền đích
            DropdownButton<String>(
              value: _toCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  _toCurrency = newValue!;
                  _toCurrencyColor = Colors.black; // Đổi màu chữ thành đen khi chọn
                });
              },
              items: CurrencyCalculatorHandler.getAvailableCurrencies()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              dropdownColor: Colors.blueAccent, // Màu nền xanh cho dropdown
              style: TextStyle(color: _toCurrencyColor), // Màu chữ thay đổi
            ),
            SizedBox(height: 20),
            // Nút chuyển đổi
            ElevatedButton(
              onPressed: _convertCurrency,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Màu nút xanh dương
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              ),
              child: Text(
                'Convert',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            // Kết quả hiển thị
            Text(
              _result,
              style: TextStyle(fontSize: 24, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}
