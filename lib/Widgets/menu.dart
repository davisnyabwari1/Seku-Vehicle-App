// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../screens/login_Screen.dart';
import 'package:seku_road_app/utilities/appData.dart';
import 'package:seku_road_app/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:seku_road_app/utilities/app_services.dart';

AppData appData = AppData();

// ignore: use_key_in_widget_constructors
class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appData.showData();
    return Container(
      color: Colors.white,
      width: 280,
      child: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 165,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/avatar.png',
                      height: 90.0,
                      width: 90.0,
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          appData.myName,
                          style: const TextStyle(fontSize: 23),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          appData.myOccupation,
                          style: const TextStyle(
                            fontSize: 20,
                            color: kStatusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () async {
                FirebaseAuth _auth = FirebaseAuth.instance;
                await _auth.signOut();
                clearLoggedUserData();
                Navigator.pushNamed(context, LoginScreen.id);
                displayToast('You are logged out', context);
              },
              child: const ListTile(
                leading: Icon(
                  Icons.info,
                  size: 30,
                  color: kStatusColor,
                ),
                title: Text(
                  'Logout',
                  style: kTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
