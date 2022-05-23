import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seku_road_app/Widgets/menu.dart';
import 'package:seku_road_app/utilities/appData.dart';
import 'package:seku_road_app/utilities/app_services.dart';
import 'package:seku_road_app/utilities/geolocator_services.dart';
import 'package:seku_road_app/utilities/mapping.dart';

AppData appData = AppData();
Geo geo = Geo();

class Map extends StatefulWidget {
  final Position initialPosition;
  Map(this.initialPosition);

  static const id = 'map_screen';

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GeoLocatorService geoService = GeoLocatorService();
  double distance = 0;
  String occupation = 'none';

  final Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];

  void sendUserData() {
    appData.getUser();
    loggedInUserRef =
        FirebaseDatabase.instance.reference().child('loggedInUsers');
    loggedInUserRef.child(loggedInUser.uid).set({
      'longitude': widget.initialPosition.longitude.toString(),
      'latitude': widget.initialPosition.latitude.toString(),
      'distance': distance,
    });
  }

  @override
  void initState() {
    sendUserData();
    geoService.getCurrentLocation().listen((position) {
      centerScreen(position);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'VEHICLE POSITIONS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              fontSize: 32,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: const Icon(
              Icons.menu,
              size: 30,
            ),
          ),
        ),
        drawer: Menu(),
        body: Center(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.initialPosition.latitude,
                  widget.initialPosition.longitude),
              zoom: 18.0,
            ),
            mapType: MapType.hybrid,
            myLocationEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: markers.map((e) => e).toSet(),
          ),
        ));
  }

  Future<void> centerScreen(Position position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 18.0)));
    // signed in
    loggedInUserRef.child(loggedInUser.uid).update({
      'longitude': position.longitude.toString(),
      'latitude': position.latitude.toString(),
      'distance': await geoService.getDistance(
          position.latitude, position.longitude, -1.3706824, 37.827612)
    });
    userRef.child(loggedInUser.uid).once().then((snapshot) {
      occupation = snapshot.value['occupation'];
    });
    if (occupation == 'Driver') {
      Marker driver = Marker(
          markerId: MarkerId('driver'),
          infoWindow: InfoWindow(title: occupation),
          position: LatLng(position.latitude, position.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueMagenta));
      markers.add(driver);
      setState(() {});
    } else if (occupation == 'Student') {
      Marker rider = Marker(
          markerId: MarkerId('rider'),
          infoWindow: InfoWindow(title: occupation),
          position: LatLng(widget.initialPosition.latitude,
              widget.initialPosition.longitude),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
      markers.add(rider);
      setState(() {});
    }
    // Marker driver = Marker(
    //     markerId: MarkerId('Driver'),
    //     infoWindow: InfoWindow(title: 'Driver'),
    //     position: LatLng(position.latitude, position.longitude),
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
    // Marker rider = Marker(
    //     markerId: MarkerId('rider'),
    //     infoWindow: InfoWindow(title: 'Rider'),
    //     position: LatLng(-1.3706824, 37.827612),
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
    // setState(() {
    // markers.add(driver);
    // markers.add(rider);
    // geo.mapUser();
    // });
  }
}
