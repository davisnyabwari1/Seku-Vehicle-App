import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seku_road_app/screens/login_Screen.dart';
import 'package:seku_road_app/utilities/constants.dart';

class SplashScreen extends StatefulWidget {
  static const id = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: kStatusColor,
      systemNavigationBarColor: kStatusColor,
    ));
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushNamed(context, LoginScreen.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/logo.svg',
              color: Colors.white,
              height: 120,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SEKUROAD APP',
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(color: Colors.white),
                      fontSize: 28,
                      letterSpacing: 4.0,
                      fontWeight: FontWeight.w900),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
