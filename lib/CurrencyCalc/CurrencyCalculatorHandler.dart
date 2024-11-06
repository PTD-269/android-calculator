// CurrencyCalculatorHandler.dart
class CurrencyCalculatorHandler {
  static const Map<String, double> exchangeRates = {
    'USD': 1.0, // Base currency
    'EUR': 0.85,
    'GBP': 0.75,
    'JPY': 110.0,
    'INR': 74.0,
    'VND': 23000.0, // Added Vietnamese Dong
  };

  static double convert(String fromCurrency, String toCurrency, double amount) {
    if (exchangeRates.containsKey(fromCurrency) &&
        exchangeRates.containsKey(toCurrency)) {
      double baseAmount = amount / exchangeRates[fromCurrency]!;
      return baseAmount * exchangeRates[toCurrency]!;
    }
    throw Exception('Invalid currency');
  }

  static List<String> getAvailableCurrencies() {
    return exchangeRates.keys.toList();
  }
}
