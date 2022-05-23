import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:seku_road_app/Widgets/rounded_button.dart';
import 'package:seku_road_app/Widgets/top_screen_section.dart';
import 'package:seku_road_app/main.dart';
import 'package:seku_road_app/screens/location.dart';
import 'package:seku_road_app/screens/registration_Screen.dart';
import 'package:seku_road_app/utilities/appData.dart';
import 'package:seku_road_app/utilities/app_services.dart';
import 'package:seku_road_app/utilities/constants.dart';
import 'package:seku_road_app/Widgets/input_widget.dart';
import 'package:seku_road_app/Widgets/progress_indicator.dart';
import './map.dart';
import 'package:seku_road_app/utilities/geolocator_services.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    appData.getUser();
    super.initState();
  }

  late Position initialPosition;
  late final GeoLocatorService geoService = GeoLocatorService();
  AppData appData = AppData();
  void sendInitialPosition() async {
    initialPosition = await geoService.getInitialPosition();
    // loggedInUserRef =
    //     FirebaseDatabase.instance.reference().child('loggedInUsers');
    // loggedInUserRef.child(loggedInUser.uid).set({
    //   'longitude': initialPosition.longitude,
    //   'latitude': initialPosition.latitude,
    // });
  }

  var email;
  var password;
  final _auth = FirebaseAuth.instance;

  void loginAndAuthenticate(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: 'Authenticating Please wait ....');
        });

    final firebaseUser = (await _auth
            .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToast('Error ' + errMsg.toString(), context);
    }))
        .user;
    // save data to a map if object is not null
    if (firebaseUser != null) {
      // displayToast('You are now logged in', context);
      // Navigator.pushNamed(context, LocationScreen.id);
      // userdata saved via an id
      userRef.child(firebaseUser.uid).once().then((snap) {
        if (snap.value != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Map(initialPosition)));
          displayToast('You are now logged in', context);
        } else {
          _auth.signOut();
          displayToast('No record,Please Register', context);
        }
      });
    } else {
      Navigator.pop(context);
      displayToast('Error occurred,cannot be signed in', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    sendInitialPosition();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          bottom: 2,
        ),
        child: Column(
          children: [
            TopScreenSection(
              screenLabel: 'Login',
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 20.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InputWidget(
                      label: 'Email',
                      icon: Icons.email,
                      onchange: (value) {
                        email = value;
                      },
                    ),
                    InputWidget(
                      label: 'Password',
                      icon: Icons.lock,
                      onchange: (value) {
                        password = value;
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20.0,
                      ),
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'Forgot Password?',
                        style: kTextStyle,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            if (!email.contains('@')) {
                              displayToast('Invalid email', context);
                            } else if (password.length < 4) {
                              displayToast(
                                  'Password length should be more than 4 characters',
                                  context);
                            } else {
                              loginAndAuthenticate(context);
                            }
                          },
                          child: RoundButton(
                            label: 'LOGIN',
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: kTextStyle,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegistrationScreen.id);
                          },
                          child: const Text(
                            ' Register',
                            style: kBottomTextStyle,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
