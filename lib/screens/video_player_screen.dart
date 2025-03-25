import 'dart:io';
import 'package:flutter/material.dart';
import 'package:media_demo/models/img_entity.dart';
import 'package:video_player/video_player.dart';
import 'photo_view_screen.dart';

class VideoPlayerScreen extends StatefulWidget {
  final File videoFile;
  final List<MediaFile> mediaFiles;
  final int currentIndex;
  final int tabIndex;

  const VideoPlayerScreen({
    Key? key,
    required this.videoFile,
    required this.mediaFiles,
    required this.currentIndex,
    required this.tabIndex,
  }) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  late DateTime _lastTapTime;
  bool _isFastForwarding = false;
  String? _overlayText;
  double _overlayOpacity = 0.0;
  late int _currentIndex;
  double _dragDistance = 0.0;
  static const double _threshold = 50.0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _initializeController();
    _lastTapTime = DateTime.now();
  }

  void _initializeController() {
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _controller.play();
            _isPlaying = true;
          });
        }
      });

    _controller.addListener(() {
      if (mounted) {
        setState(() {
          if (_controller.value.position >= _controller.value.duration) {
            _isPlaying = false;
            _controller.seekTo(Duration.zero);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showOverlay(String text) {
    if (mounted) {
      setState(() {
        _overlayText = text;
        _overlayOpacity = 1.0;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _overlayOpacity = 0.0;
          });
        }
      });
    }
  }

  void _handleTap(TapUpDetails details) {
    final now = DateTime.now();
    final timeDifference = now.difference(_lastTapTime);

    if (timeDifference < const Duration(milliseconds: 300)) {
      if (details.localPosition.dx > MediaQuery.of(context).size.width / 2) {
        _seekForward();
        _showOverlay('+10 сек');
      } else {
        _seekBackward();
        _showOverlay('-10 сек');
      }
    } else {
      _lastTapTime = now;
    }
  }

  void _seekForward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition + const Duration(seconds: 10);
    _controller.seekTo(newPosition);
  }

  void _seekBackward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition - const Duration(seconds: 10);
    _controller.seekTo(newPosition);
  }

  void _startFastForward() {
    if (mounted) {
      setState(() {
        _isFastForwarding = true;
        _controller.setPlaybackSpeed(2.0);
        _showOverlay('x2');
      });
    }
  }

  void _stopFastForward() {
    if (_isFastForwarding && mounted) {
      setState(() {
        _isFastForwarding = false;
        _controller.setPlaybackSpeed(1.0);
      });
    }
  }

  void _togglePlayPause() {
    if (mounted) {
      setState(() {
        if (_controller.value.isPlaying) {
          _controller.pause();
        } else {
          _controller.play();
        }
        _isPlaying = _controller.value.isPlaying;
      });
    }
  }

  void _navigate(int delta) {
    final filteredMedia = widget.tabIndex == 0
        ? widget.mediaFiles
        : widget.tabIndex == 1
        ? widget.mediaFiles.where((media) => !media.isVideo).toList()
        : widget.mediaFiles.where((media) => media.isVideo).toList();

    final filteredIndices = List.generate(filteredMedia.length, (i) => widget.mediaFiles.indexOf(filteredMedia[i]));
    int currentFilteredIndex = filteredIndices.indexOf(_currentIndex);

    if (currentFilteredIndex == -1) {
      currentFilteredIndex = 0;
    }

    int newFilteredIndex = currentFilteredIndex + delta;
    if (newFilteredIndex < 0 || newFilteredIndex >= filteredIndices.length) {
      return;
    }

    int newIndex = filteredIndices[newFilteredIndex];
    if (newIndex != _currentIndex && newIndex >= 0 && newIndex < widget.mediaFiles.length) {
      setState(() {
        _currentIndex = newIndex;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget.mediaFiles[_currentIndex].isVideo
              ? VideoPlayerScreen(
            videoFile: widget.mediaFiles[_currentIndex].file,
            mediaFiles: widget.mediaFiles,
            currentIndex: _currentIndex,
            tabIndex: widget.tabIndex,
          )
              : PhotoViewScreen(
            imageFile: widget.mediaFiles[_currentIndex].file,
            mediaFiles: widget.mediaFiles,
            currentIndex: _currentIndex,
            tabIndex: widget.tabIndex,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (mounted) {
          setState(() {
            _dragDistance += details.delta.dx;
          });
        }
      },
      onHorizontalDragEnd: (details) {
        if (_dragDistance.abs() >= _threshold) {
          _navigate(_dragDistance < 0 ? 1 : -1);
        }
        if (mounted) {
          setState(() {
            _dragDistance = 0.0;
          });
        }
      },
      onTapUp: _handleTap,
      onLongPressStart: (_) => _startFastForward(),
      onLongPressEnd: (_) => _stopFastForward(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: _controller.value.isInitialized
              ? Stack(
            children: [
              Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: _overlayOpacity,
                duration: const Duration(milliseconds: 300),
                child: Center(
                  child: Text(
                    _overlayText ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenSize.width * 0.1,
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        Shadow(color: Colors.black, blurRadius: 8),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_controller.value.position),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.width * 0.04,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: screenSize.width * 0.06,
                        ),
                        onPressed: _togglePlayPause,
                      ),
                      Text(
                        _formatDuration(_controller.value.duration),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.width * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 40.0,
                child: Slider(
                  value: _controller.value.duration.inMilliseconds > 0
                      ? _controller.value.position.inMilliseconds /
                      _controller.value.duration.inMilliseconds
                      : 0.0,
                  onChanged: (value) {
                    final newPosition = Duration(
                      milliseconds: (_controller.value.duration.inMilliseconds * value).toInt(),
                    );
                    _controller.seekTo(newPosition);
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                ),
              ),
            ],
          )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}