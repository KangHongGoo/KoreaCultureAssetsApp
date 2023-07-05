import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GeolocatorController extends GetxController {
  LocationPermission _permissionStatus = LocationPermission.denied;
  bool _isLoading = false;
  RxDouble longitude = 0.0.obs;
  RxDouble latitude = 0.0.obs;

  Future<void> checkPermission() async {
    _isLoading = true;

    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      throw Exception('위치 서비스를 활성화해주세요.');
    }
    _permissionStatus = await Geolocator.checkPermission();
    if (_permissionStatus == LocationPermission.denied) {
      _permissionStatus = await Geolocator.requestPermission();

      if (_permissionStatus == LocationPermission.denied) {
        throw Exception('위치 권한을 허가해주세요.');
      }
    }
    Position currentPosition = await Geolocator.getCurrentPosition();

    longitude.value = currentPosition.longitude;
    latitude.value = currentPosition.latitude;

    _isLoading = false;
  }
}
