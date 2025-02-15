import 'package:flutter/material.dart';
import 'package:quotation/domain/repositories/exchange_repositorie.dart';
import 'package:quotation/services/quotation_service.dart';

class GraphicsViewModel extends ChangeNotifier {
  late QuotationService _service;

  bool isLoading = true;
  dynamic quotationUSD;
  dynamic quotationEUR;
  dynamic quotationBTC;

  GraphicsViewModel({required QuotationService service}) : _service = service;

  void updateRepository(ExchangeRepository repository) {
    _service = QuotationService(exchangeRepository: repository);
    notifyListeners();
  }

  Future<void> fetchQuotations() async {
    try {
      isLoading = true;
      notifyListeners();

      quotationUSD = await _service.getQuotationInsidePeriod('USD', 'BRL');
      quotationEUR = await _service.getQuotationInsidePeriod('EUR', 'BRL');
      quotationBTC = await _service.getQuotationInsidePeriod('BTC', 'BRL');

    } catch (e) {
      debugPrint("Error fetching quotations: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}