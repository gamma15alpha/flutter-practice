import 'package:flutter/material.dart';
import 'package:media_demo/models/audio_entity.dart';
import 'package:media_demo/models/img_entity.dart';
import '../services/media_picker_service.dart';
import '../services/audio_picker_service.dart';
import '../services/hive_service.dart';
import '../widgets/media_tile.dart';
import 'audio_player_screen.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final MediaPickerService _mediaPickerService = MediaPickerService();
  final AudioPickerService _audioPickerService = AudioPickerService();
  final HiveService _hiveService = HiveService();
  int _currentTabIndex = 0;

  Future<void> _pickMedia(bool isVideo) async {
    final media = await _mediaPickerService.pickMedia(isVideo);
    if (media != null) {
      await _hiveService.addMediaFile(media);
      setState(() {});
    }
  }

  Future<void> _pickAudio() async {
    final audio = await _audioPickerService.pickAudioOrUrl(context);
    if (audio != null) {
      await _hiveService.addAudioFile(audio);
      setState(() {});
    }
  }

  Future<void> _deleteMedia(MediaFile media) async {
    await media.delete();
    setState(() {});
  }

  Future<void> _deleteAudio(MediaAudio audio) async {
    await audio.delete();
    setState(() {});
  }

  void _showMediaPickerDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Выбрать фото'),
              onTap: () {
                Navigator.pop(context);
                _pickMedia(false);
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text('Выбрать видео'),
              onTap: () {
                Navigator.pop(context);
                _pickMedia(true);
              },
            ),
            ListTile(
              leading: Icon(Icons.music_note),
              title: Text('Добавить аудио/URL'),
              onTap: () {
                Navigator.pop(context);
                _pickAudio();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: _currentTabIndex,
      child: Builder(
        builder: (context) {
          DefaultTabController.of(context).addListener(() {
            if (mounted) setState(() => _currentTabIndex = DefaultTabController.of(context).index);
          });
          return Scaffold(
            appBar: AppBar(
              title: const Text('Media Demo'),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Все'),
                  Tab(text: 'Фото'),
                  Tab(text: 'Видео'),
                  Tab(text: 'Музыка'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _buildGridView(_hiveService.getMediaFiles(), _currentTabIndex),
                _buildGridView(_hiveService.getMediaFiles().where((media) => !media.isVideo).toList(), _currentTabIndex),
                _buildGridView(_hiveService.getMediaFiles().where((media) => media.isVideo).toList(), _currentTabIndex),
                _buildAudioGridView(_hiveService.getAudioFiles(), _currentTabIndex),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _showMediaPickerDialog,
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGridView(List<MediaFile> mediaFiles, int tabIndex) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemCount: mediaFiles.length,
        itemBuilder: (context, index) => ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Material(
            elevation: 5,
            child: GestureDetector(
              onLongPress: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Удалить элемент?'),
                    content: Text('Вы уверены, что хотите удалить этот файл?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text('Отмена'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text('Удалить'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await _deleteMedia(mediaFiles[index]);
                }
              },
              child: MediaTile(
                file: mediaFiles[index].file,
                isVideo: mediaFiles[index].isVideo,
                mediaFiles: _hiveService.getMediaFiles(),
                currentIndex: _hiveService.getMediaFiles().indexOf(mediaFiles[index]),
                tabIndex: tabIndex,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAudioGridView(List<MediaAudio> audioFiles, int tabIndex) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemCount: audioFiles.length,
        itemBuilder: (context, index) {
          String title = audioFiles[index].title;
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AudioPlayerScreen(
                  audio: audioFiles[index],
                  audioFiles: _hiveService.getAudioFiles(),
                  currentIndex: index,
                  title: title,
                ),
              ),
            ),
            onLongPress: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Удалить аудио?'),
                  content: Text('Вы уверены, что хотите удалить этот аудиофайл?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text('Удалить'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await _deleteAudio(audioFiles[index]);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.music_note, size: 40),
                    SizedBox(height: 8),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}