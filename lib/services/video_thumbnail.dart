import 'dart:io';
import 'package:flutter/services.dart';

class VideoThumbnail {
  static const MethodChannel _channel = MethodChannel('video_thumbnail');

  static Future<File?> getThumbnail(String videoPath) async {
    try {
      final String? thumbnailPath = await _channel.invokeMethod(
        'getThumbnail',
        {'videoPath': videoPath},
      );
      return thumbnailPath != null ? File(thumbnailPath) : null;
    } catch (e) {
      print('Ошибка генерации превью: $e');
      return null;
    }
  }
}