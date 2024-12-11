import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyCalculator {
  static const String _baseUrl = 'https://open.er-api.com/v6/latest/USD';
  static Map<String, double> _rates = {};
  static DateTime? _lastUpdate;

  // Modified to return null on error
  Future<double?> convert({
    required String from,
    required String to,
    required double amount,
  }) async {
    try {
      await _updateRatesIfNeeded();
      
      if (!_rates.containsKey(from) || !_rates.containsKey(to)) {
        print('Error: Currency not supported');
        return null;
      }

      double inUSD = amount / _rates[from]!;
      return inUSD * _rates[to]!;
    } catch (e) {
      print('Error in convert: $e');
      return null;
    }
  }

  static Future<void> _updateRatesIfNeeded() async {
    if (_shouldUpdate) {
      await _fetchRates();
    }
  }

  static bool get _shouldUpdate {
    if (_lastUpdate == null) return true;
    final hoursSinceUpdate = DateTime.now().difference(_lastUpdate!).inHours;
    return hoursSinceUpdate >= 1;
  }

  static Future<void> _fetchRates() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch rates');
      }

      final data = jsonDecode(response.body);
      _rates = Map<String, double>.from(data['rates']);
      _lastUpdate = DateTime.now();
    } catch (e) {
      print('Error fetching rates: $e');
      throw Exception('Network error: $e');
    }
  }
}

void main() async {
  final calculator = CurrencyCalculator();
  
  // Test valid conversion
  double? result = await calculator.convert(
    from: 'USD',
    to: 'EUR',
    amount: 100.0,
  );
  
  if (result != null) {
    print('100 USD = ${result.toStringAsFixed(2)} EUR');
  } else {
    print('Conversion failed');
  }
  
  // Test invalid currency
  result = await calculator.convert(
    from: 'INVALID',
    to: 'EUR',
    amount: 50.0,
  );
  
  if (result != null) {
    print('50 INVALID = ${result.toStringAsFixed(2)} EUR');
  } else {
    print('Conversion failed');
  }
}
