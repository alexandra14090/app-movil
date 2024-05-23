import 'dart:convert';
import 'package:http/http.dart' as http;

class GiphyService {
  final String apiKey = 'PW9IGv6qtMGQhKfUbIzaY0CIJQ4434Om';

  Future<List<dynamic>> searchGifs(String query) async {
    final response = await http.get(Uri.parse(
        'https://api.giphy.com/v1/gifs/search?api_key=$apiKey&q=$query&limit=25&offset=0&rating=G&lang=en'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception('Error al buscar GIFs');
    }
  }
}
