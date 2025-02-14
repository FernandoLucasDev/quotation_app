import 'package:intl/intl.dart';

bool isValuating(Map<String, dynamic>? data) {
  if (data == null) return false;

  final varBid = double.tryParse(data['varBid'] ?? '0');
  final pctChange = double.tryParse(data['pctChange'] ?? '0');

  return (varBid != null && varBid > 0) && (pctChange != null && pctChange > 0);
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
