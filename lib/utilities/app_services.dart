import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

//Reference for users created
DatabaseReference userRef =
    FirebaseDatabase.instance.reference().child('users');

//GlobalDatabase reference
late DatabaseReference databaseReference;

//GlobalDatabase reference for loggedInUsers
late DatabaseReference loggedInUserRef;

late User loggedInUser;
//Creating a Global auth_instance
void clearLoggedUserData() {
  loggedInUserRef.child(loggedInUser.uid).remove();
}
