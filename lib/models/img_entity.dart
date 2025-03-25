import 'dart:io';
import 'package:hive/hive.dart';

part 'img_entity.g.dart';

@HiveType(typeId: 0)
class MediaFile extends HiveObject {
  @HiveField(0)
  final String filePath;

  @HiveField(1)
  final bool isVideo;

  @HiveField(2)
  final double? latitude;

  @HiveField(3)
  final double? longitude;

  MediaFile({
    required this.filePath,
    required this.isVideo,
    this.latitude,
    this.longitude,
  });

  File get file => File(filePath);
}