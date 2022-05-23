import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seku_road_app/utilities/appData.dart';
import 'package:seku_road_app/utilities/app_services.dart';

class Geo {
  late String userId;
  late final latitude;
  late final longitude;
  late final occupation;
  List<Marker> markers = [];

  AppData appData = AppData();

  void mapUser() async {
    userId = await appData.getUser();
    loggedInUserRef =
        FirebaseDatabase.instance.reference().child('loggedInUsers/$userId');
    loggedInUserRef.once().then((snapshot) {
      latitude = snapshot.value['latitude'];
      longitude = snapshot.value['longitude'];
    });
  }
}
