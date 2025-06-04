import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quotation/config.dart';

class BackendIntegration {
  final String baseUrl;

  BackendIntegration({this.baseUrl = backendApi});

  Future<Object> get(String endpoint) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("ERROR::: could not get exchanges");
      }
    } catch(e) {
      throw Exception("ERROR::: could not request");
    }
  }

  Future<Object> post(String endpoint, dynamic body) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception("ERROR::: Failed POST with status ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("ERROR::: Failed to send POST request - $e");
    }
  }

  Future<Object> put(String endpoint, dynamic body) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.body.isNotEmpty ? json.decode(response.body) : {};
      } else {
        throw Exception("ERROR::: Failed PUT with status ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("ERROR::: Failed to send PUT request - $e");
    }
  }

  Future<Object> delete(String endpoint, [dynamic body]) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body != null ? json.encode(body) : null,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.body.isNotEmpty ? json.decode(response.body) : {};
      } else {
        throw Exception("ERROR::: Failed DELETE with status ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("ERROR::: Failed to send DELETE request - $e");
    }
  }

}