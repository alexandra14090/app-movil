import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/giphy_service.dart';
import '../services/local_storage_service.dart';
import '../state/gif_search_state.dart';
import '../themes/theme_switcher.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final giphyService = Provider.of<GiphyService>(context);
    final gifSearchState = Provider.of<GifSearchState>(context);
    final localStorageService = Provider.of<LocalStorageService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gif Mundo'),
        actions: const [
          ThemeSwitcher(),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/icons/GifMundo.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Buscar GIFs',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  gifSearchState.updateQuery(value);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus(); // Oculta el teclado
                  gifSearchState.setLoading(true);
                  final gifs = await giphyService.searchGifs(gifSearchState.query);
                  gifSearchState.updateGifs(gifs);
                  gifSearchState.setLoading(false);
                  localStorageService.saveSearchQuery(gifSearchState.query);
                },
                child: const Text('Buscar'),
              ),
              const SizedBox(height: 20),
              Text(
                'Búsquedas Recientes',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<String>>(
                future: localStorageService.getRecentSearches(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error al cargar las búsquedas recientes');
                  } else {
                    final recentSearches = snapshot.data ?? [];
                    if (recentSearches.isEmpty) {
                      return const Text('No se han realizado búsquedas recientes');
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recentSearches.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(recentSearches[index]),
                          leading: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              _searchController.text = recentSearches[index];
                              gifSearchState.updateQuery(recentSearches[index]);
                              gifSearchState.setLoading(true);
                              giphyService.searchGifs(gifSearchState.query).then((gifs) {
                                gifSearchState.updateGifs(gifs);
                                gifSearchState.setLoading(false);
                              });
                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteRecentSearch(recentSearches[index]);
                            },
                          ),
                          onTap: () {
                            _searchController.text = recentSearches[index];
                            gifSearchState.updateQuery(recentSearches[index]);
                            gifSearchState.setLoading(true);
                            giphyService.searchGifs(gifSearchState.query).then((gifs) {
                              gifSearchState.updateGifs(gifs);
                              gifSearchState.setLoading(false);
                            });
                          },
                        );
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              gifSearchState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: gifSearchState.gifs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: <Widget>[
                              Image.network(gifSearchState.gifs[index]['images']['downsized']['url']),
                              Text(gifSearchState.gifs[index]['title']),
                              ElevatedButton(
                              onPressed: () {
                                final gifData = gifSearchState.gifs[index];
                                gifSearchState.setSelectedGif(gifData); 
                                Navigator.pushNamed(
                                  context,
                                  '/download', 
                                  arguments: {
                                    'url': gifData['images']['downsized']['url'],
                                    'fileName': gifData['title'],
                                  },
                                );
                              },
                              child: const Text('Descargar'),
                            ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }

  void _deleteRecentSearch(String query) {
    Provider.of<LocalStorageService>(context, listen: false).deleteRecentSearch(query);
    setState(() {});
  }
}
