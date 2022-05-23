import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  final Geolocator geo = Geolocator();
  Stream<Position> getCurrentLocation() {
    var locationOptions = const LocationOptions(
      accuracy: LocationAccuracy.high,
      distanceFilter: 8,
    );
    return geo.getPositionStream(locationOptions);
  }

  Future<Position> getInitialPosition() async {
    return geo.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<double> getDistance(
      startLatitude, startLongitude, endLatitude, endLongitude) async {
    return geo.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }
}
