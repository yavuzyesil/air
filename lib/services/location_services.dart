import 'package:geolocator/geolocator.dart';

class LocationService {
  double? latitude;
  double? longitude;
  Position? position;

  Future<void> getLocation() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse) {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position?.latitude;
      longitude = position?.longitude;
    } else if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.unableToDetermine) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.always ||
          locationPermission == LocationPermission.always) {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
        latitude = position?.latitude;
        longitude = position?.longitude;
      }
    }
  }
}
