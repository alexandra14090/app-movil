import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logging/logging.dart';

class DownloadScreen extends StatelessWidget {
  DownloadScreen({super.key});

  final Logger _logger = Logger('DownloadScreen');

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String url = args['url'];
    final String fileName = args['fileName'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Descarga tu Gif'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _downloadFile(context, url, fileName);
          },
          child: Text('Download $fileName'),
        ),
      ),
    );
  }

  Future<void> _downloadFile(BuildContext context, String url, String fileName) async {
    final status = await _checkPermission();
    if (status) {
      try {
        await FlutterDownloader.enqueue(
          url: url,
          savedDir: '/storage/emulated/0/Download/',
          fileName: fileName,
          showNotification: true,
          openFileFromNotification: true,
        );
        _logger.info('Download started for $fileName');
        
        // Mostrar SnackBar
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡tu Gif esta descargado!'),
          ),
        );
      } catch (e) {
        _logger.severe('Error: $e');
      }
    } else {
      _logger.warning('Permission denied');
    }
  }

  Future<bool> _checkPermission() async {
    final status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
    } else {
      final result = await Permission.storage.request();
      return result.isGranted;
    }
  }
}
