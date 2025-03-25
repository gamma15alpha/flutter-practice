import 'dart:io';
import 'package:flutter/material.dart';
import 'package:media_demo/models/img_entity.dart';
import '../services/video_thumbnail.dart';
import '../screens/photo_view_screen.dart';
import '../screens/video_player_screen.dart';

class MediaTile extends StatelessWidget {
  final File file;
  final bool isVideo;
  final List<MediaFile> mediaFiles;
  final int currentIndex;
  final int tabIndex;
  final VoidCallback? onTap;

  const MediaTile({
    super.key,
    required this.file,
    required this.isVideo,
    required this.mediaFiles,
    required this.currentIndex,
    required this.tabIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => isVideo
                ? VideoPlayerScreen(
              videoFile: file,
              mediaFiles: mediaFiles,
              currentIndex: currentIndex,
              tabIndex: tabIndex,
            )
                : PhotoViewScreen(
              imageFile: file,
              mediaFiles: mediaFiles,
              currentIndex: currentIndex,
              tabIndex: tabIndex,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: isVideo
              ? FutureBuilder<File?>(
            future: VideoThumbnail.getThumbnail(file.path),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(
                        snapshot.data!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Center(
                        child: Icon(
                          Icons.play_circle_outline,
                          color: Colors.white.withOpacity(0.8),
                          size: 40,
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return _buildVideoPlaceholder();
                }
                return _buildVideoPlaceholder();
              }
              return _buildVideoPlaceholder();
            },
          )
              : Image.file(
            file,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlaceholder() {
    return Container(
      height: 200,
      color: Colors.grey[300],
      child: Center(
        child: Icon(
          Icons.videocam,
          color: Colors.grey[600],
          size: 40,
        ),
      ),
    );
  }
}