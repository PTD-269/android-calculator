import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyCalculator {
  // Single instance (Singleton pattern)
  static final CurrencyCalculator _instance = CurrencyCalculator._internal();
  factory CurrencyCalculator() => _instance;
  CurrencyCalculator._internal();

  // API configuration
  static const String _baseUrl = 'https://open.er-api.com/v6/latest/USD';
  Map<String, double> _rates = {};
  DateTime? _lastUpdate;

  // Public methods
  Future<double> convert({
    required String from,
    required String to,
    required double amount,
  }) async {
    await _updateRatesIfNeeded();
    
    if (!_rates.containsKey(from) || !_rates.containsKey(to)) {
      throw Exception('Currency not supported');
    }

    // Convert to USD first, then to target currency
    double inUSD = amount / _rates[from]!;
    return inUSD * _rates[to]!;
  }

  Future<List<String>> getAvailableCurrencies() async {
    await _updateRatesIfNeeded();
    return _rates.keys.toList();
  }

  // Private methods
  Future<void> _updateRatesIfNeeded() async {
    // Update if no rates or last update was more than 1 hour ago
    if (_shouldUpdate) {
      await _fetchRates();
    }
  }

  bool get _shouldUpdate {
    if (_lastUpdate == null) return true;
    final hoursSinceUpdate = DateTime.now().difference(_lastUpdate!).inHours;
    return hoursSinceUpdate >= 1;
  }

  Future<void> _fetchRates() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch rates');
      }

      final data = jsonDecode(response.body);
      _rates = Map<String, double>.from(data['rates']);
      _lastUpdate = DateTime.now();
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
