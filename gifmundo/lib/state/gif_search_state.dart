import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GifSearchState extends ChangeNotifier {
  String query = '';
  List<dynamic> gifs = [];
  bool isLoading = false;
  dynamic selectedGif; // Campo para almacenar el GIF seleccionado

  void updateQuery(String newQuery) {
    query = newQuery;
    notifyListeners();
  }

  void updateGifs(List<dynamic> newGifs) {
    gifs = newGifs;
    notifyListeners();
  }

  void setSelectedGif(dynamic gif) {
    selectedGif = gif;
    notifyListeners();
  }

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<void> searchGifs(String query) async {
    setLoading(true);
    final response = await http.get(Uri.parse('https://api.giphy.com/v1/gifs/search?api_key=TU_API_KEY&q=$query&limit=10'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      updateGifs(data['data']);
    } else {
      updateGifs([]);
    }
    setLoading(false);
  }
}
