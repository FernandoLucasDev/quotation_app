import 'package:quotation/domain/repositories/exchange_repository.dart';
import 'package:quotation/data/models/quotation_model.dart';

class QuotationService {
  final ExchangeRepository _exchangeRepository;

  QuotationService({required ExchangeRepository exchangeRepository})
      : _exchangeRepository = exchangeRepository;

  Future<Map<String, dynamic>> getQuotation(String from, String to, {double amount = 1.0}) async {
    try {
      Currency response = await _exchangeRepository.getExchangeRate(from, to, amount: amount);
      return response.toJson();
    } catch (e) {
      throw Exception('ERROR:::QuotationService::getQuotation: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getQuotationInsidePeriod(String from, String to, {String days = "45"}) async {
    try {
      List<Currency> response = await _exchangeRepository.getExchangeByPeriod(from, to, days);
      return response.map((c) => c.toJson()).toList();
    } catch (e) {
      throw Exception('ERROR:::QuotationService::getQuotationInsidePeriod: $e');
    }
  }

}
