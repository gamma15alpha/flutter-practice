import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:media_demo/models/audio_entity.dart';

class AudioPlayerScreen extends StatefulWidget {
  final MediaAudio audio;
  final List<MediaAudio> audioFiles;
  final int currentIndex;
  final String title;

  const AudioPlayerScreen({
    super.key,
    required this.audio,
    required this.audioFiles,
    required this.currentIndex,
    required this.title,
  });

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _player;
  late int _currentIndex;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _player = AudioPlayer();
    _initializePlayer();
    _player.onDurationChanged.listen((d) => setState(() => _duration = d));
    _player.onPositionChanged.listen((p) => setState(() => _position = p));
  }

  void _initializePlayer() async {
    if (widget.audio.isLocal && widget.audio.file != null) {
      await _player.play(DeviceFileSource(widget.audio.file!.path));
    } else if (widget.audio.url != null) {
      await _player.play(UrlSource(widget.audio.url!));
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _playPause() async {
    if (_player.state == PlayerState.playing) {
      await _player.pause();
    } else {
      await _player.resume();
    }
  }

  void _seekForward() async {
    final newPosition = _position + const Duration(seconds: 10);
    await _player.seek(newPosition > _duration ? _duration : newPosition);
  }

  void _seekBackward() async {
    final newPosition = _position - const Duration(seconds: 10);
    await _player.seek(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  void _navigate(int delta) {
    int newIndex = _currentIndex + delta;
    if (newIndex >= 0 && newIndex < widget.audioFiles.length) {
      setState(() => _currentIndex = newIndex);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AudioPlayerScreen(
            audio: widget.audioFiles[_currentIndex],
            audioFiles: widget.audioFiles,
            currentIndex: _currentIndex,
            title: widget.audioFiles[_currentIndex].title,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Slider(
            value: _position.inSeconds.toDouble(),
            max: _duration.inSeconds.toDouble(),
            onChanged: (value) {
              _player.seek(Duration(seconds: value.toInt()));
            },
            activeColor: Colors.purple,
            inactiveColor: Colors.grey,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(icon: Icon(Icons.skip_previous, color: Colors.white), onPressed: () => _navigate(-1)),
              IconButton(icon: Icon(Icons.replay_10, color: Colors.white), onPressed: _seekBackward),
              IconButton(icon: Icon(_player.state == PlayerState.playing ? Icons.pause : Icons.play_arrow, color: Colors.white), onPressed: _playPause),
              IconButton(icon: Icon(Icons.forward_10, color: Colors.white), onPressed: _seekForward),
              IconButton(icon: Icon(Icons.skip_next, color: Colors.white), onPressed: () => _navigate(1)),
            ],
          ),
          Text(
            '${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')} / ${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}