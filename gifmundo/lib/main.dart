import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/giphy_service.dart';
import 'services/local_storage_service.dart';
import 'state/gif_search_state.dart';
import 'state/theme_provider.dart'; 
import 'screens/search_screen.dart';
import 'themes/themes.dart'; 

void main() {
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GiphyService>(create: (_) => GiphyService()),
        ChangeNotifierProvider<GifSearchState>(create: (_) => GifSearchState()),
        Provider<LocalStorageService>(create: (_) => LocalStorageService()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme, 
            themeMode: themeProvider.themeMode, 
            home: const SearchScreen(), 
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
