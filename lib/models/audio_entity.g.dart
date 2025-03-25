// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaAudioAdapter extends TypeAdapter<MediaAudio> {
  @override
  final int typeId = 1;

  @override
  MediaAudio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MediaAudio(
      filePath: fields[0] as String?,
      url: fields[1] as String?,
      isLocal: fields[2] as bool,
      title: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MediaAudio obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.filePath)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.isLocal)
      ..writeByte(3)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaAudioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
