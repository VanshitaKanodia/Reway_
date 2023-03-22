// ignore_for_file: unused_local_variable, import_of_legacy_library_into_null_safe, dead_code

import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class Location {
  double? latitude;
  double? longitude;
  Location();
  Future<void> getpos() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;

    print(LatLng(latitude, longitude));
  }
}
