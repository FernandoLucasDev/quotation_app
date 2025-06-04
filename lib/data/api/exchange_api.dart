import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quotation/config.dart';

class ExchangeApi {
  final String baseUrl;

  ExchangeApi({this.baseUrl = awesomeApiUrl});

  Future<List<Map<String, dynamic>>> fetchExchangeByPeriod(String from, String to, String days) async {
    final url = Uri.parse('${baseUrl}daily/$from-$to/$days');

    try {

      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        List<Map<String, dynamic>> formattedData = data.map((item) {
          return item as Map<String, dynamic>;
        }).toList();

        return formattedData;
      } else {
        throw Exception("ERROR::: could not get exchanges");
      }
    } catch (e) {
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