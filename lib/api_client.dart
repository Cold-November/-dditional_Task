import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  final String baseUrl;

  ApiClient({required this.baseUrl});

  Future<List<dynamic>> fetchNews(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/$category'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load news');
    }
  }
}
