import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const kStatusColor = Color(0xFF388e3c);

const kBottomTextStyle = TextStyle(
  fontSize: 20,
  color: kStatusColor,
  fontWeight: FontWeight.bold,
);
const kGoogleMapAPIKey = 'AIzaSyAPhBDx9A8CafmiLeQkCmwBJ0p9z_6UXOQ';

const kTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.black54,
);

const kButtonTextDecoration = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const kScreenLabel = TextStyle(
  color: Colors.white,
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

//Display dialogs on the screen for the user
displayToast(String msg, BuildContext context) {
  Fluttertoast.showToast(msg: msg);
}
