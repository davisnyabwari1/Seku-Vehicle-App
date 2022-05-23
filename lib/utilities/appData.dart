import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'app_services.dart';

class AppData {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future getUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        return loggedInUser.uid;
      }
    } catch (e) {
      print(e);
    }
  }

  late String myName = '';
  late String myOccupation = '';
  void showData() async {
    var userid = await getUser();
    databaseReference =
        FirebaseDatabase.instance.reference().child('users/$userid');
    databaseReference.once().then((snapshot) {
      myName = snapshot.value['name'];
      myOccupation = snapshot.value['occupation'];
    });
  }
}
