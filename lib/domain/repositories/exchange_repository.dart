import 'package:quotation/data/api/exchange_api.dart';
import 'package:quotation/data/models/quotation_model.dart';
import 'package:quotation/utils/bid_formatters.dart';

class ExchangeRepository {

  final ExchangeApi _api;

  ExchangeRepository({required ExchangeApi api}) : _api = api;

  Future<Currency> getExchangeRate(String from, String to, {double amount = 1.0}) async {
    try {

      Map<String, dynamic> response = await _api.fetchExchangeRate(from, to);

      Currency currency = Currency.fromJson(response);

      return Currency(
        code: currency.code,
        codein: currency.codein,
        name: currency.name,
        high: currency.high,
        low: currency.low,
        varBid: currency.varBid,
        pctChange: currency.pctChange,
        bid: currency.bid * amount,
        ask: currency.ask,
        timestamp: currency.timestamp,
        createDate: currency.createDate,
        amount: (double.parse(response['bid']) * amount).toString(),
        isCurrencyValuating: isValuating(response)
      );

    } catch (e) {
      throw Exception('ERROR:::ExchangeRepository::getExchangeRate: $e');
    }
  }

  Future<List<Currency>> getExchangeByPeriod(String from, String to, String days) async {
    try {
      List<Map<String, dynamic>> response = await _api.fetchExchangeByPeriod(from, to, days);
      if (response.isNotEmpty) {
        List<Currency> currencies = response.map((json) => Currency.fromJson(json)).toList();

        currencies[0] = Currency(
          code: currencies[0].code,
          codein: currencies[0].codein,
          name: currencies[0].name,
          high: currencies[0].high,
          low: currencies[0].low,
          varBid: currencies[0].varBid,
          pctChange: currencies[0].pctChange,
          bid: currencies[0].bid,
          ask: currencies[0].ask,
          timestamp: currencies[0].timestamp,
          createDate: currencies[0].createDate,
          isCurrencyValuating: isValuationByPeriod(response)
        );
        return currencies;
      }

      return [];

    } catch (e) {
      throw Exception("ERROR::: $e");
    }
  }


}
