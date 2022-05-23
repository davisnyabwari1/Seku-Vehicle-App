import 'dart:async';
// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:seku_road_app/Widgets/menu.dart';
import 'package:seku_road_app/utilities/appData.dart';
// import 'package:seku_road_app/utilities/appData.dart';
import 'package:seku_road_app/utilities/app_services.dart';
import 'package:firebase_database/firebase_database.dart';

AppData appData = AppData();

class LocationScreen extends StatefulWidget {
  static String id = 'locationScreen';

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // LatLng sourceLocation = LatLng(, longitude);

  // late Position currentPosition;

  late GoogleMapController _controller;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appData.showData();
    // getPosition();
  }

  void addLoggedUSerCoordinates() {
    loggedInUserRef =
        FirebaseDatabase.instance.reference().child('loggedInUsers');
    loggedInUserRef.child(loggedInUser.uid).set({
      // 'longitude': currentPosition.longitude.toString(),
      // 'latitude': currentPosition.latitude.toString(),
    });
  }

  void getPosition() async {
    // LocationPermission permission;
    // await Provider.of<AppData>(context).showData();
    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   Position position = await Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.low);
    //   // currentPosition = position;
    //   // print('${currentPosition.longitude}${currentPosition.latitude}');
    // } else {
    //   Position position = await Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.low);
    //   currentPosition = position;
    //   addLoggedUSerCoordinates();
    // }

    // // print('longitude is ${currentPosition.longitude}');
    //Grabs both the latitude and longitude
    // LatLng latPosition =
    //     LatLng(currentPosition.latitude, currentPosition.longitude);
    // //Change cameraPosition
    // CameraPosition cameraPosition =
    //     CameraPosition(target: latPosition, zoom: 14.4746);
    // newGoogleMapController
    //     .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static final CameraPosition _initialLocation = const CameraPosition(
    target: LatLng(37.86667025520001, -1.3693693693693694),
    zoom: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'VEHICLE POSITIONS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            fontSize: 32,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            scaffoldKey.currentState?.openDrawer();
          },
          child: Icon(
            Icons.menu,
            size: 30,
          ),
        ),
      ),
      drawer: Menu(),
      // bottomNavigationBar: BottomNavigator(),
      // body: GoogleMap(
      //   // initialCameraPosition: _initialLocation,
      //   // mapType: MapType.hybrid,
      //   // onMapCreated: (GoogleMapController controller) {
      //   //   _controller = controller;
      //   // },
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     getPosition();
      //   },
      //   child: Icon(Icons.location_searching),
      // ),
    );
  }
}
