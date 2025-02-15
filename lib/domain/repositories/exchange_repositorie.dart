import 'package:quotation/data/api/exchange_api.dart';
import 'package:quotation/utils/bid_formatters.dart';

class ExchangeRepository {

  final ExchangeApi _api;

  ExchangeRepository({required ExchangeApi api}) : _api = api;

  Future<Map<String, dynamic>> getExchangeRate(String from, String to, {double amount = 1.0}) async {
    try {

      Map<String, dynamic> response = await _api.fetchExchangeRate(from, to);
      response['amount'] = double.parse(response['bid']) * amount;
      response['isCurrencyValuating'] = isValuating(response);
      return response;

    } catch (e) {
      throw Exception('ERROR:::ExchangeRepository::getExchangeRate: $e');
    }
  }
}
