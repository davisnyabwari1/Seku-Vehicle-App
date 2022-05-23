import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:seku_road_app/screens/location.dart';
import 'package:seku_road_app/screens/login_Screen.dart';
import 'package:seku_road_app/screens/splash_Screen.dart';
import 'package:seku_road_app/screens/registration_Screen.dart';
import 'package:seku_road_app/utilities/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:seku_road_app/utilities/geolocator_services.dart';

DatabaseReference loggedInUsers =
    FirebaseDatabase.instance.reference().child('loggedInUsers');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(create: (_) => AppData()),
  //   ],
  // );
  await Firebase.initializeApp();
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: kStatusColor,
  //   ),
  // );

  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  final geoService = GeoLocatorService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Consumer<Position>(
      //   builder: (context, position, widget) {
      //     return (position != null)
      //         ? Map(position)
      //         : Center(
      //             child: CircularProgressIndicator(),
      //           );
      //   },
      // ),
      initialRoute: SplashScreen.id,
      theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: kStatusColor,
              )),
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        LocationScreen.id: (context) => LocationScreen(),
      },
    );
  }
}
