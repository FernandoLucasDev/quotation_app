import 'dart:convert';
import 'package:http/http.dart' as http;

class ExchangeApi {
  final String baseUrl;

  ExchangeApi({this.baseUrl = 'https://economia.awesomeapi.com.br/json/last/'});

  Future<Map<String, dynamic>> fetchExchangeRate(String from, String to) async {
    final url = Uri.parse('$baseUrl$from-$to');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data.containsKey('$from$to')) {
          return data['$from$to'];
        } else {
          throw Exception('Quotation not found.');
        }
      } else {
        throw Exception('Fail: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('ERROR: $e');
    }
  }
}