import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiEndPoints {
  final String apiKey = "apikey=c4cd507f5b96dcac88cfaff79d641cbf";
  final String hash = "hash=0b2d763fffb21f4090edc942d779c460";
  final String ts = "ts=1";

  Future<List<dynamic>> fetchCharacters() async {
    String baseUrl = "https://gateway.marvel.com/v1/public/characters";

    final response = await http.get(Uri.parse('$baseUrl?$apiKey&$ts&$hash'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['results'];
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<List<dynamic>> fetchComics() async {
    String baseUrl = "https://gateway.marvel.com/v1/public/comics";

    final response = await http.get(Uri.parse('$baseUrl?$apiKey&$ts&$hash'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['results'];
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<List<dynamic>> fetchComicsCreator() async {
    String baseUrl = "https://gateway.marvel.com/v1/public/creators";

    final response = await http.get(Uri.parse('$baseUrl?$apiKey&$ts&$hash'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['results'];
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<List<dynamic>> fetchSeries() async {
    String baseUrl = "https://gateway.marvel.com/v1/public/series";

    final response = await http.get(Uri.parse('$baseUrl?$apiKey&$ts&$hash'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['results'];
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<List<dynamic>> fetchHistorys() async {
    String baseUrl = "https://gateway.marvel.com/v1/public/series";

    final response = await http.get(Uri.parse('$baseUrl?$apiKey&$ts&$hash'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['results'];
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
