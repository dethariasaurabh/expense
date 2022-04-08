import 'package:expense/screens/code_verification_screen.dart';
import 'package:expense/utils/ui_utils.dart';
import 'package:expense/widgets/app_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;

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
}
