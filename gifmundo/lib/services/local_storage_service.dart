import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> saveSearchQuery(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> recentSearches = prefs.getStringList('recentSearches') ?? [];
    if (!recentSearches.contains(query)) {
      recentSearches.add(query);
      await prefs.setStringList('recentSearches', recentSearches);
    }
  }

  Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('recentSearches') ?? [];
  }

  Future<void> deleteRecentSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> recentSearches = prefs.getStringList('recentSearches') ?? [];
    recentSearches.remove(query);
    await prefs.setStringList('recentSearches', recentSearches);
  }
}
