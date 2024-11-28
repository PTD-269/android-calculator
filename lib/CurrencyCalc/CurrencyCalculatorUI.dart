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
                labelStyle: TextStyle(color: Colors.blueAccent), 
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent), 
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent), // Viền khi focus xanh dương
                ),
              ),
              keyboardType: TextInputType.number, 
              textInputAction: TextInputAction.done, 
              onSubmitted: (value) {
                _convertCurrency(); // Khi nhấn Enter, thực hiện chuyển đổi
              },
            ),
            SizedBox(height: 20),
            // Dropdown cho đồng tiền xuất phát
            GestureDetector(
              onTap: () async {
                // Giới hạn hiệu ứng mờ 
                FocusScope.of(context).requestFocus(FocusNode());
                final selectedCurrency = await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: Text("Select Currency"),
                      children: CurrencyCalculatorHandler.getAvailableCurrencies()
                          .map<Widget>((String value) {
                        return SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, value);
                          },
                          child: Text(value),
                        );
                      }).toList(),
                    );
                  },
                );
                if (selectedCurrency != null) {
                  setState(() {
                    _fromCurrency = selectedCurrency;
                    _fromCurrencyColor = Colors.black; 
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Text(
                      _fromCurrency,
                      style: TextStyle(color: _fromCurrencyColor, fontSize: 18),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: _fromCurrencyColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Dropdown for second input field
            GestureDetector(
              onTap: () async {
                // unlimited focusScope
                FocusScope.of(context).requestFocus(FocusNode());
                final selectedCurrency = await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: Text("Select Currency"),
                      children: CurrencyCalculatorHandler.getAvailableCurrencies()
                          .map<Widget>((String value) {
                        return SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, value);
                          },
                          child: Text(value),
                        );
                      }).toList(),
                    );
                  },
                );
                if (selectedCurrency != null) {
                  setState(() {
                    _toCurrency = selectedCurrency;
                    _toCurrencyColor = Colors.black; 
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Text(
                      _toCurrency,
                      style: TextStyle(color: _toCurrencyColor, fontSize: 18),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: _toCurrencyColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Nút chuyển đổi
            ElevatedButton(
              onPressed: _convertCurrency,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // blue button
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              ),
              child: Text(
                'Convert',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            // result
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
