import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:media_demo/models/audio_entity.dart';

class AudioPickerService {
  Future<MediaAudio?> pickAudioOrUrl(BuildContext context) async {
    try {
      final choice = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Добавить аудио'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context, 'url'),
                child: Text('Добавить по URL'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, 'local'),
                child: Text('Выбрать локальный файл'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Отмена'),
            ),
          ],
        ),
      );

      if (choice == null) return null;

      if (choice == 'url') {
        String? url = await _showUrlInputDialog(context);
        if (url != null && url.isNotEmpty) {
          MediaAudio audio = MediaAudio(url: url, isLocal: false);
          audio.setTitleFromPathOrUrl();
          return audio;
        }
      } else if (choice == 'local') {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['mp3', 'wav', 'aac'],
        );
        if (result != null && result.files.isNotEmpty) {
          MediaAudio audio = MediaAudio(filePath: result.files.single.path!, isLocal: true);
          audio.setTitleFromPathOrUrl();
          return audio;
        }
      }
      return null;
    } catch (e) {
      print('Ошибка при выборе аудио: $e');
      return null;
    }
  }

  Future<String?> _showUrlInputDialog(BuildContext context) async {
    String? result;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Введите URL аудио'),
        content: TextField(
          decoration: InputDecoration(labelText: 'URL (например, https://example.com/audio.mp3)'),
          onChanged: (value) => result = value,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, result),
            child: Text('OK'),
          ),
        ],
      ),
    );
    return result;
  }
}