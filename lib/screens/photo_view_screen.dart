import 'dart:io';
import 'package:flutter/material.dart';
import 'package:media_demo/models/img_entity.dart';
import 'package:photo_view/photo_view.dart';
import 'video_player_screen.dart';

class PhotoViewScreen extends StatefulWidget {
  final File imageFile;
  final List<MediaFile> mediaFiles;
  final int currentIndex;
  final int tabIndex;

  const PhotoViewScreen({
    super.key,
    required this.imageFile,
    required this.mediaFiles,
    required this.currentIndex,
    required this.tabIndex,
  });

  @override
  _PhotoViewScreenState createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  late int _currentIndex;
  double _dragDistance = 0.0;
  static const double _threshold = 50.0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
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
    final currentMedia = widget.mediaFiles[_currentIndex];

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _dragDistance += details.delta.dx;
        });
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
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: screenSize.width,
                  maxHeight: screenSize.height,
                ),
                child: PhotoView(
                  imageProvider: FileImage(widget.imageFile),
                  backgroundDecoration: const BoxDecoration(color: Colors.black),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 2.0,
                  initialScale: PhotoViewComputedScale.contained,
                  heroAttributes: const PhotoViewHeroAttributes(tag: 'photo'),
                ),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.black.withOpacity(0.6),
                child: Text(
                  currentMedia.latitude != null && currentMedia.longitude != null
                      ? 'Геопозиция: ${currentMedia.latitude!.toStringAsFixed(4)}, ${currentMedia.longitude!.toStringAsFixed(4)}'
                      : 'Геопозиция не указана',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}