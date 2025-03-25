import 'package:image_picker/image_picker.dart';
import 'package:media_demo/models/img_entity.dart';
import 'location_service.dart';

class MediaPickerService {
  final ImagePicker _picker = ImagePicker();
  final LocationService _locationService = LocationService();

  Future<MediaFile?> pickMedia(bool isVideo) async {
    try {
      final pickedFile = isVideo
          ? await _picker.pickVideo(source: ImageSource.gallery)
          : await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        Map<String, double>? location;
        if (!isVideo) {
          location = await _locationService.getCurrentLocation();
        }
        return MediaFile(
          filePath: pickedFile.path,
          isVideo: isVideo,
          latitude: location?['latitude'],
          longitude: location?['longitude'],
        );
      }
      return null;
    } catch (e) {
      print('Ошибка при выборе медиа: $e');
      return null;
    }
  }
}