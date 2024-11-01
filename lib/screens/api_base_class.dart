import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  static const timeoutDuration = Duration(seconds: 10);

  ApiService(this.baseUrl);

  Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Error handling method
  dynamic _handleError(http.Response response) {
    if (response.statusCode >= 400 && response.statusCode < 500) {
      throw Exception('Client error: ${response.statusCode}');
    } else if (response.statusCode >= 500) {
      throw Exception('Server error: ${response.statusCode}');
    } else {
      throw Exception('Unknown error: ${response.statusCode}');
    }
  }

  // Process response method
  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      return _handleError(response);
    }
  }

  // GET request with timeout
  Future<dynamic> get(String endpoint) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final response = await http.get(url, headers: _headers).timeout(timeoutDuration);
      return _processResponse(response);
    } on TimeoutException {
      throw Exception('Request timed out');
    } catch (error) {
      throw Exception('Error in GET request: $error');
    }
  }

  // POST request with timeout
  Future<dynamic> post(String endpoint, dynamic body) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final response = await http.post(url, headers: _headers, body: jsonEncode(body)).timeout(timeoutDuration);
      return _processResponse(response);
    } on TimeoutException {
      throw Exception('Request timed out');
    } catch (error) {
      throw Exception('Error in POST request: $error');
    }
  }

  // PUT request with timeout
  Future<dynamic> put(String endpoint, dynamic body) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final response = await http.put(url, headers: _headers, body: jsonEncode(body)).timeout(timeoutDuration);
      return _processResponse(response);
    } on TimeoutException {
      throw Exception('Request timed out');
    } catch (error) {
      throw Exception('Error in PUT request: $error');
    }
  }

  // DELETE request with timeout
  Future<dynamic> delete(String endpoint) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final response = await http.delete(url, headers: _headers).timeout(timeoutDuration);
      return _processResponse(response);
    } on TimeoutException {
      throw Exception('Request timed out');
    } catch (error) {
      throw Exception('Error in DELETE request: $error');
    }
  }
}
