import 'dart:io';
import 'package:hive/hive.dart';

part 'audio_entity.g.dart';

@HiveType(typeId: 1)
class MediaAudio extends HiveObject {
  @HiveField(0)
  final String? filePath;

  @HiveField(1)
  final String? url;

  @HiveField(2)
  final bool isLocal;

  @HiveField(3)
  String title;

  MediaAudio({
    this.filePath,
    this.url,
    required this.isLocal,
    this.title = 'Аудио',
  });

  File? get file => filePath != null ? File(filePath!) : null;

  void setTitleFromPathOrUrl() {
    title = filePath?.split('/').last ?? url?.split('/').last ?? 'Аудио';
  }
}