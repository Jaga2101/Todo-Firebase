import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/alert.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<User?> signInWithGoogle() async {
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

  // Once signed in, return the UserCredential
  UserCredential authResult =
      await FirebaseAuth.instance.signInWithCredential(credential);

  return authResult.user;
}

Future<User?> signInWithEmailPassword(String email, String password) async {
  try {
    // Sign in with email and password
    UserCredential authResult = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Return the signed-in user
    return authResult.user;
  } catch (e) {
    // Handle errors
    CustomAlert(
      tit: 'Login Falied\n$e',
      ico: Icons.error,
      col: Colors.red,
      des: "Retry",
      onPressed: () {},
    );
    print("Error during Email/Password Sign-In: $e");
    return null;
  }
}

Future<User?> signUpWithEmailPassword(String email, String password) async {
  try {
    // Create user with email and password
    UserCredential authResult = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Return the signed-up user
    return authResult.user;
  } catch (e) {
    // Handle errors
    print("Error during Email/Password Sign-Up: $e");
    return null;
  }
}

Future<void> signOutUser() async {
  try {
    // Check if user signed in with Google
    if (_googleSignIn.currentUser != null) {
      await _googleSignIn.disconnect();
    }

    // Sign out from Firebase
    await _auth.signOut();
  } catch (e) {
    // Handle errors
    print("Error during Sign-Out: $e");
  }
}


// Future<User?> signInWithGoogle() async {
//   try {
//     // Trigger Google Sign In
//     GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//     if (googleUser == null) {
//       // User cancelled the sign-in process
//       return null;
//     }

//     // Get Google Sign In Authentication
//     GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//     // Create Firebase credentials
//     AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     // Sign in to Firebase
//     UserCredential authResult = await _auth.signInWithCredential(credential);

//     // Return the signed-in user
//     return authResult.user;
//   } catch (e) {
//     // Handle errors
//     print("Error during Google Sign-In: $e");
//     return null;
//   }
// }
