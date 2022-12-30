import 'dart:developer' as dev;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:team_reminder_frontend/controllers/user_controller.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  final result = await FirebaseAuth.instance.signInWithCredential(credential);

  updateUserInfo(FirebaseAuth.instance.currentUser!.uid, {
    'name': result.user?.displayName,
    'email': result.user?.email,
    'photoURL': result.user?.photoURL,
  });

  // Once signed in, return the UserCredential
  return result;
}
