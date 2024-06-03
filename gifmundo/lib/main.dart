import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'services/giphy_service.dart';
import 'services/local_storage_service.dart';
import 'state/gif_search_state.dart';
import 'state/theme_provider.dart';
import 'screens/search_screen.dart';
import 'screens/download_screen.dart';
import 'screens/about_us_screen.dart'; 
import 'screens/contact_us_screen.dart';
import 'screens/login_screen.dart'; // Importa la pantalla de inicio de sesión
import 'themes/themes.dart';
import 'package:logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeDownloader();
  _setupLogging();
  runApp(const MyApp());
}

Future<void> _initializeDownloader() async {
  await FlutterDownloader.initialize(debug: true);
  await _requestPermissions();
}

Future<void> _requestPermissions() async {
  final status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
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
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: '/login', // Establece la pantalla de inicio de sesión como la ruta inicial
            routes: {
              '/': (context) => const SearchScreen(),
              '/download': (context) => DownloadScreen(),
              '/about': (context) => const AboutUsScreen(), 
              '/contact': (context) => const ContactUsScreen(),
              '/login': (context) => const LoginScreen(), // Ruta de la pantalla de inicio de sesión
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
