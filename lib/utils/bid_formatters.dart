import 'package:intl/intl.dart';

bool isValuating(Map<String, dynamic>? data) {
  if (data == null) return false;

  final varBid = double.tryParse(data['varBid'] ?? '0');
  final pctChange = double.tryParse(data['pctChange'] ?? '0');

  return (varBid != null && varBid > 0) && (pctChange != null && pctChange > 0);
}

Map<String, bool> isValuationByPeriod(List<dynamic> data) {
  Map<String, bool> periodValuation = {
    "5": double.parse(data[0]["bid"]) > double.parse(data[4]["bid"]),
    "10": double.parse(data[0]["bid"]) > double.parse(data[9]["bid"]),
    "15": double.parse(data[0]["bid"]) > double.parse(data[14]["bid"]),
    "30": double.parse(data[0]["bid"]) > double.parse(data[29]["bid"]),
    "45": double.parse(data[0]["bid"]) > double.parse(data[44]["bid"])
  };
  return periodValuation;
}

String formatBitcoinValue(String rawValue) {
  int? numericValue = int.tryParse(rawValue);
  if (numericValue == null) {
    return 'Valor inválido';
  }
  final formatter = NumberFormat.decimalPattern('pt_BR');
  return formatter.format(numericValue);
}

String formatToTwoDecimalPlaces(String rawValue) {
  double? numericValue = double.tryParse(rawValue);
  if (numericValue == null) {
    return 'Valor inválido';
  }
  final formatter = NumberFormat('#,##0.00', 'pt_BR');
  return formatter.format(numericValue);
}
