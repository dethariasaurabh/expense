import 'package:firebase_core/firebase_core.dart';

class FirebaseServices {
  static initFirebase() async {
    await Firebase.initializeApp();
  }
}
