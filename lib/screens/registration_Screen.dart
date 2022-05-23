import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seku_road_app/Widgets/progress_indicator.dart';
import 'package:seku_road_app/Widgets/rounded_button.dart';
import 'package:seku_road_app/Widgets/top_screen_section.dart';
import 'package:seku_road_app/main.dart';
import 'package:seku_road_app/screens/location.dart';
import 'package:seku_road_app/screens/login_Screen.dart';
import 'package:seku_road_app/utilities/app_services.dart';
import 'package:seku_road_app/utilities/constants.dart';
import 'package:seku_road_app/Widgets/input_widget.dart';

class RegistrationScreen extends StatefulWidget {
  //Associates the id with the Registration screen
  static const id = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // firebaseAuth object instance created
  final _auth = FirebaseAuth.instance;

  //Variables for the userInputs
  var email;
  var password;
  late String fullName;
  late String phoneNumber;
  late String occupation;

  //Function to register new user to firebase realtime database
  void registerNewUSer(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return ProgressDialog(message: 'Registering Please Wait...');
        });
    final firebaseUser = (await _auth
            .createUserWithEmailAndPassword(
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
      Map userDataMap = {
        "name": fullName.trim(),
        "password": password.trim(),
        "email": email.trim(),
        "occupation": occupation.trim(),
      };
      // userdata saved via an id
      userRef.child(firebaseUser.uid).set(userDataMap).asStream();
      displayToast('Registration Successful,Please login', context);
      Navigator.pushNamed(context, LoginScreen.id);
    } else {
      displayToast('Account not created', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(
          bottom: 2,
        ),
        child: Column(
          children: [
            TopScreenSection(screenLabel: 'Registration'),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InputWidget(
                      label: 'FullName',
                      icon: Icons.account_circle_sharp,
                      onchange: (value) {
                        fullName = value;
                      },
                    ),
                    InputWidget(
                      label: 'PhoneNumber',
                      icon: Icons.phone,
                      onchange: (value) {
                        phoneNumber = value;
                      },
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PillButton(
                          label: 'Student',
                          onchange: () {
                            occupation = 'Student';
                          },
                        ),
                        PillButton(
                          label: 'Driver',
                          onchange: () {
                            occupation = 'Driver';
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (fullName.length < 4) {
                            displayToast(
                                'FullName must be more than 4 characters',
                                context);
                          } else if (phoneNumber.isEmpty) {
                            displayToast(
                                'PhoneNumber is a mandatory field', context);
                          } else if (!email.contains('@')) {
                            displayToast('Invalid email', context);
                          } else if (password.length < 4) {
                            displayToast(
                                'Password length should be more than 4 characters',
                                context);
                          } else {
                            registerNewUSer(context);
                          }
                        },
                        child: Center(
                          child: RoundButton(
                            label: 'REGISTER',
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already an account?",
                          style: kTextStyle,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            ' Login',
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

class PillButton extends StatelessWidget {
  final String label;
  final Function()? onchange;
  PillButton({required this.label, required this.onchange});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: GestureDetector(
          onTap: onchange,
          child: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              label,
              style: kButtonTextDecoration,
            ),
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: kStatusColor,
            ),
          ),
        ),
      ),
    );
  }
}
