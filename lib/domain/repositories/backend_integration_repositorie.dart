import 'package:quotation/data/api/exchange_api.dart';
import 'package:quotation/data/models/quotation_model.dart';
import 'package:quotation/utils/bid_formatters.dart';

class BackendIntegrationRepository {

  final ExchangeApi _api;

  BackendIntegrationRepository({required ExchangeApi api}) : _api = api;

}
