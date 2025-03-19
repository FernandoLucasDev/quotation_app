class Currency {
  final String? code;
  final String? codein;
  final String? name;
  final double high;
  final double low;
  final double varBid;
  final double pctChange;
  final double bid;
  final double ask;
  final int timestamp;
  final String? createDate;
  final String? amount;
  final dynamic? isCurrencyValuating;

  Currency({
    this.code,
    this.codein,
    this.name,
    required this.high,
    required this.low,
    required this.varBid,
    required this.pctChange,
    required this.bid,
    required this.ask,
    required this.timestamp,
    this.createDate,
    this.amount,
    this.isCurrencyValuating,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'],
      codein: json['codein'],
      name: json['name'],
      high: double.tryParse(json['high'].toString()) ?? 0.0,
      low: double.tryParse(json['low'].toString()) ?? 0.0,
      varBid: double.tryParse(json['varBid'].toString()) ?? 0.0,
      pctChange: double.tryParse(json['pctChange'].toString()) ?? 0.0,
      bid: double.tryParse(json['bid'].toString()) ?? 0.0,
      ask: double.tryParse(json['ask'].toString()) ?? 0.0,
      amount: json['amount'].toString(),
      isCurrencyValuating: json['isCurrencyValuating'] ?? false,
      timestamp: int.tryParse(json['timestamp'].toString()) ?? 0,
      createDate: json['create_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'codein': codein,
      'name': name,
      'high': high.toString(),
      'low': low.toString(),
      'varBid': varBid.toString(),
      'pctChange': pctChange.toString(),
      'bid': bid.toString(),
      'ask': ask.toString(),
      'timestamp': timestamp.toString(),
      'create_date': createDate,
      'amount': amount,
      'isCurrencyValuating': isCurrencyValuating,
    };
  }

}
