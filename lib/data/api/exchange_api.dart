import 'dart:convert';
import 'package:http/http.dart' as http;

class ExchangeApi {
  final String baseUrl;

  ExchangeApi({this.baseUrl = 'https://economia.awesomeapi.com.br/json/'});
  
  Future<List<dynamic>> fetchExchangeByPeriod(String from, String to, String days) async {
    final url = Uri.parse('${baseUrl}daily/$from-$to/$days');

    try {
      final response = await http.get(url);

      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        throw Exception("ERROR::: could not get exchanges");
      }
    } catch(e) {
      print("3");
      throw Exception("ERROR::: $e");
    }
  }

  Future<Map<String, dynamic>> fetchExchangeRate(String from, String to) async {
    final url = Uri.parse('${baseUrl}last/$from-$to');

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