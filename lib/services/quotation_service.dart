import 'package:quotation/domain/repositories/exchange_repositorie.dart';

class QuotationService {
  final ExchangeRepository _exchangeRepository;

  QuotationService({required ExchangeRepository exchangeRepository})
      : _exchangeRepository = exchangeRepository;

  Future<Map<String, dynamic>> getQuotation(String from, String to, {double amount = 1.0}) async {
    try {
      var response = await _exchangeRepository.getExchangeRate(from, to, amount: amount);
      return response;
    } catch (e) {
      throw Exception('ERROR:::QuotationService::getQuotation: $e');
    }
  }
}
