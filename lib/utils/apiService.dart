import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.tvmaze.com/search/shows";

  static Future<List<dynamic>> fetchMovies(String query) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$query'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load movies");
    }
  }
}
