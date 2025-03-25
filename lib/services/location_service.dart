import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  Future<Map<String, double>?> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return null;
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return null;
    }

    final locationData = await _location.getLocation();
    return {
      'latitude': locationData.latitude!,
      'longitude': locationData.longitude!,
    };
  }
}