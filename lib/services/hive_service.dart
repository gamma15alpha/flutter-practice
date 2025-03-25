import 'package:hive/hive.dart';
import 'package:media_demo/models/audio_entity.dart';
import 'package:media_demo/models/img_entity.dart';

class HiveService {
  static const String mediaBoxName = 'mediaFiles';
  static const String audioBoxName = 'audioFiles';

  Future<void> init() async {
    await Hive.openBox<MediaFile>(mediaBoxName);
    await Hive.openBox<MediaAudio>(audioBoxName);
  }

  Box<MediaFile> getMediaBox() => Hive.box<MediaFile>(mediaBoxName);
  Box<MediaAudio> getAudioBox() => Hive.box<MediaAudio>(audioBoxName);

  Future<void> addMediaFile(MediaFile media) async {
    final box = getMediaBox();
    await box.add(media);
  }

  Future<void> addAudioFile(MediaAudio audio) async {
    final box = getAudioBox();
    await box.add(audio);
  }

  List<MediaFile> getMediaFiles() => getMediaBox().values.toList();
  List<MediaAudio> getAudioFiles() => getAudioBox().values.toList();
}