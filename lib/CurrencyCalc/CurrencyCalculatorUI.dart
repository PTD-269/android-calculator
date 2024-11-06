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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _amountController,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          DropdownButton<String>(
            value: _fromCurrency,
            onChanged: (String? newValue) {
              setState(() {
                _fromCurrency = newValue!;
              });
            },
            items: CurrencyCalculatorHandler.getAvailableCurrencies()
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          DropdownButton<String>(
            value: _toCurrency,
            onChanged: (String? newValue) {
              setState(() {
                _toCurrency = newValue!;
              });
            },
            items: CurrencyCalculatorHandler.getAvailableCurrencies()
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _convertCurrency,
            child: Text('Convert'),
          ),
          SizedBox(height: 20),
          Text(
            _result,
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
