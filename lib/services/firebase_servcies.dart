import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense/screens/onboarding/code_verification_screen.dart';
import 'package:expense/utils/ui_utils.dart';
import 'package:expense/widgets/app_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class FirebaseServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static initFirebase() async {
    await Firebase.initializeApp();
  }

  signInWithPhoneNumber({
    required BuildContext buildContext,
    required String phoneNumber,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (AuthCredential credential) async {
        // await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException exception) {
        showAlertDialog(
          context: buildContext,
          title: 'Alert!',
          message: exception.message!,
          buttonText: 'OK',
        );
      },
      codeSent: (String verificationId, int? resendToken) async {
        navigateTo(
          CodeVerificationScreen(
            firebaseAuth: auth,
            phoneNumber: phoneNumber,
            verificationId: verificationId,
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  static User? getCurrentUser() {
    if (auth.currentUser == null) return null;
    return auth.currentUser;
  }

  static Future<DocumentSnapshot> getUserData(String userUid) async {
    final CollectionReference snapShot = firestore.collection('users');
    final DocumentSnapshot data = await snapShot.doc(userUid).get();
    return data;
  }

  static Future<void> setUserData({
    required String userUid,
    required Map<String, dynamic> appUser,
  }) async {
    await firestore.collection('users').doc(userUid).set(appUser).then((value) {
      return value;
    });
  }
}
